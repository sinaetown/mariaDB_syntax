-- INSERT, SELECT, UPDATE, DELETE

-- INSERT
-- 테이블에 새로운 레코드를 추가
INSERT INTO 테이블이름(필드이름1, 필드이름2 ..) values (데이터값1, 데이터값2 ..);
-- ex) INSERT INTO author(id, name, email) VALUES (1, 'kim', 'abc@naver.com');

-- UPDATE
-- 테이블 레코드의 내용을 수정
UPDATE 테이블이름 SET 필드이름1=데이터값, 필드이름2=데이터값2 ... WHERE 필드이름=데이터값;
-- WHERE절 생략 시, 해당 테이블의 모든 레코드값이 위 설정대로 수정되므로 유의
-- ex) UPDATE author SET email='abc2@test.com' WHERE id=1;

-- 여기서 =는:
-- WHERE 문 뒤에 나오는 비교문은 java기준으로 ==
-- 어떤 값을 set할 때도 =을 사용하여 대입 (java =와 동일)

-- DELETE
-- 테이블에 데이터 삭제
DELETE FROM 테이블이름 WHERE 필드이름=데이터값;
-- ex) DELETE FROM author WHERE author_id=3;