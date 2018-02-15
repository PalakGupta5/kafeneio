package com.kafeneio.service;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.kafeneio.DTO.MessageDTO;
import com.kafeneio.constants.ApplicationConstant;
import com.kafeneio.model.ModeOfPayment;
import com.kafeneio.model.Order;
import com.kafeneio.model.OrderDetails;
import com.kafeneio.model.OrderStatus;
import com.kafeneio.repository.ModeOfPaymentRepository;
import com.kafeneio.repository.OrderDAO;
import com.kafeneio.repository.OrderRepository;
import com.kafeneio.repository.OrderStatusRepository;

@Service
public class BillingServiceImpl extends BaseServiceImpl implements BillingService{
	
	@Inject
	OrderRepository orderRepository;
	
	@Inject
	OrderStatusRepository orderStatusRepository;

	@Inject
	ModeOfPaymentRepository modeOfPaymentRepository;
	
	@Inject
	OrderDAO orderDao;
	
	@Override
	public synchronized MessageDTO saveOrder(Order order, Long mopId, String date){
		MessageDTO msgDTO = new MessageDTO();
		try{
			order.setOrderNo(this.getOrderNo(date));
				if(isOrderExist(order.getOrderNo())){
					msgDTO.setMessage("Order <b>"+order.getOrderNo()+"</b> already taken, Change the order Number!");
					msgDTO.setStatusCode(HttpStatus.ALREADY_REPORTED.value());
				}
				else{
					populateOrder(order,date);
					OrderStatus orderStatus = orderStatusRepository.findByCode(ApplicationConstant.NEW_ORDER);
					order.setStatus(orderStatus);
					if(mopId != null){
						ModeOfPayment modeOfPayment = modeOfPaymentRepository.findOne(mopId);
						order.setModeOfPayment(modeOfPayment);
					}
					
					orderRepository.save(order);
					msgDTO.setMessage("Order"+order.getOrderNo()+" saved Successfully!");
					msgDTO.setStatusCode(HttpStatus.OK.value());
				}
		}
		catch(Exception exception){
			exception.printStackTrace();
			msgDTO.setMessage("Error");
			msgDTO.setStatusCode(HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
		return msgDTO;
	}

	private boolean isOrderExist(Long orderNo) {
		List<Long> orders = orderDao.findRecentOrder();
		if(orders != null && !orders.isEmpty()){
			return orders.get(0).equals(orderNo);
		}
		else return false;
	}

	private void populateOrder(Order order, String date) throws ParseException {
		double amount = 0;
		//order.setOrderNo(orderNo);
		DateFormat format = new SimpleDateFormat(ApplicationConstant.DATE_TIME_FORMAT);
		if((date!=null && !date.isEmpty())){
			order.setCreationDate(format.parse(date));
		}
		else{
			order.setCreationDate(new Date());
		}
		Iterator<OrderDetails> itr = order.getOrderDetails().iterator();	
		while(itr.hasNext()){
			OrderDetails orderDetails= itr.next();
			amount=amount+((orderDetails.getAmount()!=null)?orderDetails.getAmount():0);
			orderDetails.setCreationDate(order.getCreationDate());	
		}
		order.setAmount(amount);
		if(order.getGstAmount() != null){
			order.setAmount(Double.sum(order.getAmount(),order.getGstAmount()));
		}
	}
	public Long getOrderNo(String date) throws ParseException{
		Long orderNo = orderDao.findOrderNo(date);
		orderNo=(orderNo!=null)?(orderNo+1):ApplicationConstant.BASE_ORDER_NO;
		return orderNo;
	}
}
