package com.zhenhappy.ems.manager.dto;

import com.zhenhappy.ems.dto.BaseRequest;

import java.util.Date;

/**
 * Created by wujianbin on 2014-07-03.
 */
public class ResetVisitorInlandOrOutlandRequest extends BaseRequest {
	private Integer id;
	private Integer country;
	private String province;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCountry() {
		return country;
	}

	public void setCountry(Integer country) {
		this.country = country;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}
}
