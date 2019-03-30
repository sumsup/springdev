package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor // 아마도, 모든 멤버 변수를 파라미터로 받는 생성자를 만들어 주는 것인듯.
@Getter
public class ReplyPageDTO { // 리플 갯수와 리플 목록을 넣는 클래스.
	
	private int replyCnt;
	private List<ReplyVO> list;
	
}
