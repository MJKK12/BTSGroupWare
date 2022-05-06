package com.spring.bts.jieun.model;

import java.util.List;
import java.util.Map;

public interface InterCalendarDAO {

	// === 서브 캘린더 가져오기 === //
	List<CalendarVO> selectCalNo(Map<String, String> paraMap);
	
	// === 일정 등록 하기 === //
	int scheduleRegisterInsert(Map<String, String> paraMap);
	
	// === 사내 캘린더에 사내 캘린더 소분류 추가하기 === //
	int addComCalendar(Map<String, String> paraMap);

	// === 사내 캘린더에 사내 캘린더 소분류 보여주기 === //
	List<CalendarVO> showCompanyCalendar();


	// === 일정 체크 박스 추가 === //
	//int addCalenderName(CalenderVO calendervo);
	
}
