#SELECT DATABASE (0~16)
SELECT num

#모든 key값 조회
KEYS *

#키 삭제
DEL key

#전체 키 삭제
FLUSHDB

#cmd창 정리
clear

#SET 문법
# If same key is 'set' again, then it overwrites
SET key value

#GET 문법
GET key

#NX 문법(Not exists)
#nx means if not exists
#If the same key is 'set' again using 'nx', then it does nothing
SET key value NX

#EX 문법 (Expire)
SET key value EX 초단위시간 

#ex)
set merry christmas
get merry # Then prints, 'christmas'

set merry day
get merry # Then prints, 'day'

#when merry-christmas is the key-value:
set merry day nx 
get merry # Still prints out 'christmas'

set happy day ex 10
get happy # Then prints, 'day'
#after 10 seconds,
get happy # Then prints, (nil)

set session:id1234 hong@naver.com ex 1800 

#Data 추가
LPUSH key value
RPUSH key value

#Data 추출
LPOP key #pop from left
RPOP key #pop from right

#LIST의 길이
LLEN key

#Member 조회
LRANGE key start end 
# 끝까지 조회면 -1 

#TTL (Time To Live) = 유효시간
ttl[key] #남은 만료시간 확인

#set_name here equals key

#집합에 멤버 추가
SADD set_name member

#집합의 모든 멤버 반환
SMEMBERS set_name

#특정 멤버 삭제
SREM set_name member1 member2 ...

#SET의 길이
SCARD set_name

#zset에 멤버 추가
ZADD key score member
#score : 멤버 정렬하는 데 사용되는 점수 (Weight)

#member형식을 json형식으로도 가능
#ex) ZADD my_key 1 '{"hello":"world"}'

#특정 키의 특정 멤버 삭제
ZREM key member

#특정 멤버의 위치 정보 반환 (오름차순)
#index starts from 0
ZRANK key member

#특정 멤버의 위치 정보 반환 (내림차순)
#index starts from 0
ZREVRANK key member

#score기준 오름차순 조회
ZRANGE key 0 -1

#score기준 내림차순 조회
ZREVRANGE key 0 -1

#ex) 
#좋아요 수 counter
set likes 0
incr likes
incr likes
get likes
#Then prints out 2

decr likes
get likes
#Then prints out 1

#ex) 동시성 문제 해결
set key value ex 10
#10초 동안 락 걸기

#ex) 예약 시스템
ZADD key 시간 이메일
ZRANK key member 
#대기열 몇 번째 -> 사용자 편의 높임
#->가장 처음에 있는 사용자 del