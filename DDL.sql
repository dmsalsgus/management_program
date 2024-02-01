/* 관리자 */
CREATE TABLE tblAdmin (
	admin_num NUMBER PRIMARY KEY, /* 관리자번호 */
	name varchar2(100) NOT NULL, /* 이름 */
    pw varchar2(100) NOT NULL, /* 주민번호 뒷자리 */
	tel varchar2(100) /* 전화번호 */
);
/* 관리자출퇴근내역 */
CREATE TABLE tblAdminAttendance (
	attendance_num NUMBER PRIMARY KEY, /* 출퇴근번호 */
	admin_num NUMBER NOT NULL REFERENCES tblAdmin(admin_num), /* 관리자번호 */
	att_date DATE NOT NULL, /* 날짜 */
	att_state VARCHAR2(100) NOT NULL /* 근태상황 */
);
/* 지원자 */
CREATE TABLE tblApplicant (
	applicant_num NUMBER PRIMARY KEY, /* 지원자번호 */
	name varchar2(100) NOT NULL, /* 이름 */
	tel varchar2(100) NOT NULL /* 전화번호 */
);
/* 면접 */
CREATE TABLE tblInterview (
	interview_num NUMBER PRIMARY KEY, /* 면접번호 */
	applicant_num NUMBER NOT NULL REFERENCES tblApplicant(applicant_num), /* 지원자번호 */
	admin_num NUMBER NOT NULL REFERENCES tblAdmin(admin_num), /* 관리자번호 */
	interview_date DATE NOT NULL, /* 면접일 */
	interview_result varchar2(100) NOT NULL /* 면접결과 */
);
/* 과정 */
CREATE TABLE tblCurriculum (
	curriculum_num NUMBER PRIMARY KEY, /* 과정번호 */
	curriculum varchar2(100) NOT NULL /* 과정명 */
);
/* 강의실 */
CREATE TABLE tblClassroom (
	classroom_num NUMBER PRIMARY KEY, /* 강의실번호 */
	classroom varchar2(100) NOT NULL, /* 강의실명 */
	total_people NUMBER NOT NULL /* 정원 */
);
/* 개설과정 */
CREATE TABLE tblOpenCurriculum (
	open_curriculum_num NUMBER PRIMARY KEY, /* 개설과정번호 */
	curriculum_num NUMBER NOT NULL REFERENCES tblCurriculum(curriculum_num), /* 과정번호 */
	classroom_num NUMBER NOT NULL REFERENCES tblClassroom(classroom_num), /* 강의실번호 */
	start_date DATE NOT NULL, /* 과정시작일 */
	end_date DATE NOT NULL, /* 과정종료일 */
	period NUMBER NOT NULL /* 과정기간 */
);
/* 공지사항 */
CREATE TABLE tblNotice (
	notice_num NUMBER PRIMARY KEY, /* 공지번호 */
	open_curriculum_num NUMBER NOT NULL REFERENCES tblOpenCurriculum(open_curriculum_num), /* 개설과정번호 */
	admin_num NUMBER NOT NULL REFERENCES tblAdmin(admin_num), /* 관리자번호 */
	notice varchar2(3000) NOT NULL, /* 공지사항내용 */
	notice_date DATE NOT NULL, /* 공지일 */
	views NUMBER DEFAULT 0 NOT NULL /* 조회수 */
);
/* 수업계획서 */
CREATE TABLE tblPlan (
	plan_num NUMBER PRIMARY KEY, /* 계획서번호 */
	open_curriculum_num NUMBER NOT NULL REFERENCES tblOpenCurriculum(open_curriculum_num), /* 개설과정번호 */
	plan_week NUMBER NOT NULL, /* 주차 */
	plan_content varchar2(3000) NOT NULL /* 내용 */
);
/* 교육생 */
CREATE TABLE tblStudent (
	student_num NUMBER PRIMARY KEY, /* 교육생번호 */
	name varchar2(100) NOT NULL, /* 이름 */
	pw varchar2(100) NOT NULL, /* 주민번호 뒷자리 */
	tel varchar2(100) /* 전화번호 */
);
/* 수강과정 */
CREATE TABLE tblRegister (
	register_num NUMBER PRIMARY KEY, /* 수강과정번호 */
	student_num NUMBER NOT NULL REFERENCES tblStudent(student_num), /* 교육생번호 */
	open_curriculum_num NUMBER NOT NULL REFERENCES tblOpenCurriculum(open_curriculum_num), /* 개설과정번호 */
	register_date DATE NOT NULL /* 등록일 */
);
/* 출결 */
CREATE TABLE tblAttendance (
	attendance_num NUMBER PRIMARY KEY, /* 출결번호 */
	register_num NUMBER NOT NULL REFERENCES tblRegister(register_num), /* 수강과정번호 */
	att_date DATE NOT NULL, /* 날짜 */
	att_state VARCHAR2(100) NOT NULL /* 근태상황 */
);
/* 중도탈락내역 */
CREATE TABLE tblDrop (
	register_num NUMBER PRIMARY KEY, /* 수강과정번호 */
	drop_date DATE NOT NULL, /* 중도탈락일 */
    CONSTRAINT fk_tblDrop_register_num FOREIGN KEY (register_num) REFERENCES tblRegister(register_num)
);
/* 수료내역 */
CREATE TABLE tblComplete (
	register_num NUMBER PRIMARY KEY, /* 수강과정번호 */
	complete_date DATE NOT NULL, /* 수료일 */
    CONSTRAINT fk_tblComplete_register_num FOREIGN KEY (register_num) REFERENCES tblRegister(register_num)
);
/* 수강후기 */
CREATE TABLE tblReview (
	review_num NUMBER PRIMARY KEY, /* 후기번호 */
	register_num NUMBER NOT NULL REFERENCES tblRegister(register_num), /* 수강과정번호 */
	review varchar2(3000) NOT NULL, /* 후기내용 */
	review_date DATE NOT NULL /* 작성일 */
);
/* 취업 */
CREATE TABLE tblEmployment (
	register_num NUMBER PRIMARY KEY, /* 수강과정번호 */
	employment_state varchar2(100) NOT NULL, /* 취업여부 */
	field varchar2(100), /* 취업분야 */
	insurance_state varchar2(100), /* 고용보험가입여부 */
    CONSTRAINT fk_tblEmployment_register_num FOREIGN KEY (register_num) REFERENCES tblRegister(register_num)
);
/* 교사 */
CREATE TABLE tblProfessor (
	professor_num NUMBER PRIMARY KEY, /* 교사번호 */
	name varchar2(100) NOT NULL, /* 이름 */
	pw varchar2(100) NOT NULL, /* 주민번호 뒷자리 */
	tel varchar2(100), /* 전화번호 */
    state varchar2(100) NOT NULL /* 상태 */
);
/* 교사출퇴근내역 */
CREATE TABLE tblProfessorAttendance (
	attendance_num NUMBER PRIMARY KEY, /* 출퇴근번호 */
	professor_num NUMBER NOT NULL REFERENCES tblProfessor(professor_num), /* 교사번호 */
	att_date DATE NOT NULL, /* 날짜 */
	att_state VARCHAR2(100) NOT NULL /* 근태상황 */
);
/* 과목 */
CREATE TABLE tblSubject (
	subject_num NUMBER PRIMARY KEY, /* 과목번호 */
	subject varchar2(100) NOT NULL, /* 과목명 */
	common_sub_state varchar2(100) NOT NULL /* 공통과목여부 */
);
/* 추천도서 */
CREATE TABLE tblBestBook (
	bestbook_num NUMBER PRIMARY KEY, /* 추천도서번호 */
	subject_num NUMBER NOT NULL REFERENCES tblSubject(subject_num), /* 과목번호 */
	book varchar2(100) NOT NULL, /* 도서명 */
	publisher varchar2(100) NOT NULL /* 출판사 */
);
/* 강의가능과목 */
CREATE TABLE tblAbleSubject (
	able_subject_num NUMBER PRIMARY KEY, /* 강의가능과목번호 */
	professor_num NUMBER NOT NULL REFERENCES tblProfessor(professor_num), /* 교사번호 */
	subject_num NUMBER NOT NULL REFERENCES tblSubject(subject_num) /* 과목번호 */
);
/* 교재 */
CREATE TABLE tblBook (
	book_num NUMBER PRIMARY KEY, /* 교재번호 */
	book varchar2(100) NOT NULL, /* 교재명 */
	publisher varchar2(100) NOT NULL /* 출판사 */
);
/* 개설과목 */
CREATE TABLE tblOpenSubject (
	open_subject_num NUMBER PRIMARY KEY, /* 개설과목번호 */
	open_curriculum_num NUMBER NOT NULL REFERENCES tblOpenCurriculum(open_curriculum_num), /* 개설과정번호 */
	able_subject_num NUMBER NOT NULL REFERENCES tblAbleSubject(able_subject_num), /* 강의가능과목번호 */
	book_num NUMBER NOT NULL REFERENCES tblBook(book_num), /* 교재번호 */
	start_date DATE NOT NULL, /* 과목시작일 */
	end_date DATE NOT NULL, /* 과목종료일 */
	sub_progress_state varchar2(100) NOT NULL /* 강의진행여부 */
);
/* 시험 */
CREATE TABLE tblTest (
	test_num NUMBER PRIMARY KEY, /* 시험번호 */
	open_subject_num NUMBER NOT NULL REFERENCES tblOpenSubject(open_subject_num), /* 개설과목번호 */
	test_file varchar2(100) NOT NULL, /* 시험문제파일 */
	test_date DATE NOT NULL, /* 시험일 */
	att_ratio NUMBER, /* 출결배점 */
	write_ratio NUMBER, /* 필기배점 */
	practical_ratio NUMBER, /* 실기배점 */
	score_registration_state varchar2(100) NOT NULL /* 성적등록여부 */
);
/* 수강과목 */
CREATE TABLE tblCourse (
	course_num NUMBER PRIMARY KEY, /* 수강과목번호 */
	register_num NUMBER NOT NULL REFERENCES tblRegister(register_num), /* 수강과정번호 */
	open_subject_num NUMBER NOT NULL REFERENCES tblOpenSubject(open_subject_num) /* 개설과목번호 */
);
/* 성적 */
CREATE TABLE tblScore (
	score_num NUMBER PRIMARY KEY, /* 성적번호 */
	test_num NUMBER NOT NULL REFERENCES tblTest(test_num), /* 시험번호 */
	course_num NUMBER NOT NULL REFERENCES tblCourse(course_num), /* 수강과목번호 */
	att_score NUMBER DEFAULT 0 NOT NULL, /* 출결점수 */
	write_score NUMBER DEFAULT 0 NOT NULL, /* 필기점수 */
	practical_score NUMBER DEFAULT 0 NOT NULL /* 실기점수 */
);
/* 상담 */
CREATE TABLE tblCounsel (
	counsel_num NUMBER PRIMARY KEY, /* 상담번호 */
	register_num NUMBER NOT NULL REFERENCES tblRegister(register_num), /* 수강과정번호 */
	counsel varchar2(3000) NOT NULL, /* 상담내용 */
	counsel_date DATE NOT NULL /* 상담일 */
);
/* 질문내역 */
CREATE TABLE tblQuestion (
	question_num NUMBER PRIMARY KEY, /* 질문번호 */
	course_num NUMBER NOT NULL REFERENCES tblCourse(course_num), /* 수강과목번호 */
	question varchar2(3000) NOT NULL, /* 질문내용 */
	question_date DATE NOT NULL /* 질문일 */
);
/* 답변내역 */
CREATE TABLE tblAnswer (
	answer_num NUMBER PRIMARY KEY, /* 답변번호 */
	question_num NUMBER NOT NULL REFERENCES tblQuestion(question_num), /* 질문번호 */
	answer varchar2(3000) NOT NULL, /* 답변내용 */
	answer_date DATE NOT NULL /* 답변일 */
);
/* 프로젝트 */
CREATE TABLE tblProject (
	project_num NUMBER PRIMARY KEY, /* 프로젝트번호 */
	course_num NUMBER NOT NULL REFERENCES tblCourse(course_num), /* 수강과목번호 */
	project_file varchar2(3000) NOT NULL, /* 프로젝트파일 */
	project_date DATE NOT NULL /* 제출일 */
);
/* 과제 */
CREATE TABLE tblTask (
	task_num NUMBER PRIMARY KEY, /* 과제번호 */
	course_num NUMBER NOT NULL REFERENCES tblCourse(course_num), /* 수강과목번호 */
	task_file varchar2(100) NOT NULL, /* 과제파일 */
	task_date DATE NOT NULL /* 제출일 */
);

CREATE SEQUENCE admin_seq;
CREATE SEQUENCE admin_att_seq;
CREATE SEQUENCE applicant_seq;
CREATE SEQUENCE interview_seq;
CREATE SEQUENCE curriculum_seq;
CREATE SEQUENCE classroom_seq;
CREATE SEQUENCE open_curriculum_seq;
CREATE SEQUENCE notice_seq;
CREATE SEQUENCE plan_seq;
CREATE SEQUENCE student_seq;
CREATE SEQUENCE register_seq;
CREATE SEQUENCE att_seq;
CREATE SEQUENCE review_seq;
CREATE SEQUENCE employment_seq;
CREATE SEQUENCE professor_seq;
CREATE SEQUENCE prof_att_seq;
CREATE SEQUENCE sub_seq;
CREATE SEQUENCE bestbook_seq;
CREATE SEQUENCE able_subject_seq;
CREATE SEQUENCE book_seq;
CREATE SEQUENCE open_subject_seq;
CREATE SEQUENCE course_seq;
CREATE SEQUENCE test_seq;
CREATE SEQUENCE score_seq;
CREATE SEQUENCE counsel_seq;
CREATE SEQUENCE question_seq;
CREATE SEQUENCE answer_seq;
CREATE SEQUENCE project_seq;
CREATE SEQUENCE task_seq;
