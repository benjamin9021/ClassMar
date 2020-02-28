package com.naver.dto;

import java.io.Serializable;

public class MsgDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int mid;
	private String sender;
	private String receiver;
	
	public MsgDTO() {
		// TODO Auto-generated constructor stub
	}

	public MsgDTO(int mid, String sender, String receiver) {
		super();
		this.mid = mid;
		this.sender = sender;
		this.receiver = receiver;
	}

	public int getMid() {
		return mid;
	}

	public void setMid(int mid) {
		this.mid = mid;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + mid;
		result = prime * result + ((receiver == null) ? 0 : receiver.hashCode());
		result = prime * result + ((sender == null) ? 0 : sender.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MsgDTO other = (MsgDTO) obj;
		if (mid != other.mid)
			return false;
		if (receiver == null) {
			if (other.receiver != null)
				return false;
		} else if (!receiver.equals(other.receiver))
			return false;
		if (sender == null) {
			if (other.sender != null)
				return false;
		} else if (!sender.equals(other.sender))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MsgDTO [mid=" + mid + ", sender=" + sender + ", receiver=" + receiver + "]";
	}
	
	
	
	
	
	
}
