package com.example.demo;

public class Product {
	private String code;
	private String name;
	private int price;
	private int unitsInStock;
	private String manufacturer;
	private int quantity;

	public Product(String code, String name, int price, int unitsInStock, String manufacturer) {
		super();
		this.code = code;
		this.name = name;
		this.price = price;
		this.unitsInStock = unitsInStock;
		this.manufacturer = manufacturer;
	}

	public Product() {
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getUnitsInStock() {
		return unitsInStock;
	}

	public void setUnitsInStock(int unitsInStock) {
		this.unitsInStock = unitsInStock;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
}
