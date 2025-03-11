package com.xoa.model.weChatNotice;

public class ModelData {

	private Base first = new Base();
	
	private Base keyword1 = new Base();
	
	private Base keyword2 = new Base();
	
	private Base keyword3 = new Base();
	
	private Base keyword4 = new Base();
	
	private Base remark = new Base();
	
	public Base getFirst() {
		return first;
	}

	public void setFirst(Base first) {
		this.first = first;
	}

	public Base getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(Base keyword1) {
		this.keyword1 = keyword1;
	}

	public Base getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(Base keyword2) {
		this.keyword2 = keyword2;
	}

	public Base getKeyword3() {
		return keyword3;
	}

	public void setKeyword3(Base keyword3) {
		this.keyword3 = keyword3;
	}

	public Base getKeyword4() {
		return keyword4;
	}

	public void setKeyword4(Base keyword4) {
		this.keyword4 = keyword4;
	}

	public Base getRemark() {
		return remark;
	}

	public void setRemark(Base remark) {
		this.remark = remark;
	}

	public class Base {
		String value;
		
		String color;

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}

		public String getColor() {
			return color;
		}

		public void setColor(String color) {
			this.color = color;
		}
	}
}
