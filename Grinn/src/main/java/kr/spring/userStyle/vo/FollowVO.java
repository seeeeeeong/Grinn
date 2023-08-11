package kr.spring.userStyle.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FollowVO {
	private int follow_id;
	private int to_user;
	private int from_user;
}
