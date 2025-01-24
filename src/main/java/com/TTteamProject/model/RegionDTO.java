package com.TTteamProject.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegionDTO {
	private int region_idx;
	private String region_name;
	
	public RegionDTO(String region_name) {
		this.region_name = region_name;
		if(region_name.equals("REGION_NAME 1")) {
			this.region_idx = 1;
		}
	}
}

