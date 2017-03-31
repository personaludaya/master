package com.brands.core.models;

import java.util.List;

/**
 * FAQ Model based on data.json
 * @author eugeneng
 *
 */
public class Faq {
	private String type = "faq";
	private String title; //the faq question
	private String content; //the faq answer
	private List<String>bulletList; //additional list items
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public List<String> getBulletList() {
		return bulletList;
	}
	public void setBulletList(List<String> bulletList) {
		this.bulletList = bulletList;
	}
}
