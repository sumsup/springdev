package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor // �Ƹ���, ��� ��� ������ �Ķ���ͷ� �޴� �����ڸ� ����� �ִ� ���ε�.
@Getter
public class ReplyPageDTO { // ���� ������ ���� ����� �ִ� Ŭ����.
	
	private int replyCnt;
	private List<ReplyVO> list;
	
}
