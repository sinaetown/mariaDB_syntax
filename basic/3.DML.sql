-- INSERT, SELECT, UPDATE, DELETE

-- INSERT
-- 테이블에 새로운 레코드를 추가
INSERT INTO 테이블이름(필드이름1, 필드이름2 ..) values (데이터값1, 데이터값2 ..);
-- ex) INSERT INTO author(id, name, email) VALUES (1, 'kim', 'abc@naver.com');

-- SELECT
SELECT 필드이름 FROM 테이블이름 WHERE 조건
-- ex) SELECT * FROM author;
-- ex) SELECT name, email FROM author WHERE id=3;
-- ex) SELECT * FROM author WHERE id>1;
-- ex) SELECT * FROM author WHERE id>1 AND name='kim';

-- 이름 중복 제거하고 조회
SELECT DISTINCT 필드명 FROM 테이블명;
-- ex) SELECT DISTINCT NAME FROM author;

--정렬
SELECT * FROM 테이블명 ORDER BY 필드명 [ASC/DESC]
-- ex) SELECT * FROM author order by id desc;

-- ORDER BY 멀티 : 먼저 쓴 column 우선 정렬 + 생략시 ASC 적용
-- 여러 필드의 데이터를 쉼표 사용해서 여러 기준으로 정렬 가능
-- ORDER BY 생략 시, PK 기준으로 오름차순 정렬하여 결과값 변환
-- ex) SELECT * FROM author order by name desc, email asc;
-- => name 우선 내림차순 정렬 + email 오름차순 정렬

-- LIMIT 숫자 : 특정 숫자로 결과값 개수 확인
SELECT * FROM AUTHOR LIMIT 숫자
-- ex) SELECT * FROM author ORDER BY id DESC LIMIT 2


-- ALIAS 별칭을 이용한 처리
-- 테이블과 필드에 임시로 별칭 부여하고 해당 별칭을 SELECT문에서 상요
SELECT 필드이름 AS 별칭 FROM 테이블이름;
SELECT 필드이름 FROM 테이블이름 AS 별칭;

-- ALIAS 이용한 SELECT문
-- AS는 생략 가능
-- ex) SELECT NAME AS 이름 FROM author;
-- ex) SELECT NAME 이름, email FROM author;

-- ex) SELECT NAME, email FROM author AS a; 
-- => 다른 테이블인데 같은 이름을 가진 column 구별할 때 사용
-- 두 테이블이 관련되어 있을 때 헷갈리지 않도록

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