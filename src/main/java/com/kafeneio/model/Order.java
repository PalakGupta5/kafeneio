package com.kafeneio.model;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.kafeneio.utils.CustomDateDeserializer;

@Entity
@Table(name="KAFENEIO_ORDER")
public class Order {
	
		@Id
		@GeneratedValue(strategy=GenerationType.AUTO)
		@Column(name="id" ,unique=true,nullable=false )
		private Long id;
		@Column(name="order_no")
		private Long orderNo;
		@Column(name="amount")
		private Double amount;
		@Column(name="table_no")
		private String table;
//		@JsonFormat(pattern = ApplicationConstant.DATE_FORMAT)
		@Column(name="creation_date")
		private Date creationDate;
		
		
		@Column(name="discount_percentage")
		private Long discountPercentage;
		
		@OneToMany(mappedBy="order", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
		@OrderBy("id ASC")
		@Column(nullable = true)
		@JsonManagedReference
		private Set<OrderDetails> orderDetails ;
		 
		@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	    @JoinColumn(name="status")
	 	private OrderStatus status;

		@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	    @JoinColumn(name="mode_of_payment")
	 	private ModeOfPayment modeOfPayment ;

		
		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public Long getOrderNo() {
			return orderNo;
		}

		public void setOrderNo(Long orderNo) {
			this.orderNo = orderNo;
		}

		public Double getAmount() {
			return amount;
		}

		public void setAmount(Double amount) {
			this.amount = amount;
		}

		public Set<OrderDetails> getOrderDetails() {
			return orderDetails;
		}

		public void setOrderDetails(Set<OrderDetails> orderDetails) {
			this.orderDetails = orderDetails;
		}
		
		@JsonDeserialize(using = CustomDateDeserializer.class)
		public Date getCreationDate() {
			return creationDate;
		}

		public void setCreationDate(Date creationDate) {
			this.creationDate = creationDate;
		}

		public OrderStatus getStatus() {
			return status;
		}

		public void setStatus(OrderStatus status) {
			this.status = status;
		}

		public String getTable() {
			return table;
		}

		public void setTable(String table) {
			this.table = table;
		}

		public ModeOfPayment getModeOfPayment() {
			return modeOfPayment;
		}
		
		public void setModeOfPayment(ModeOfPayment modeOfPayment) {
			this.modeOfPayment = modeOfPayment;
		}

		public Long getDiscountPercentage() {
			return discountPercentage;
		}

		public void setDiscountPercentage(Long discountPercentage) {
			this.discountPercentage = discountPercentage;
		}

}
