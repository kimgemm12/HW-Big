-- [VI] SUB QUERY " QUERY안에 QUERY가 내포
-- 1. 서브쿼리 개념
-- 서브쿼리    (1)   단일행서브쿼리(서브쿼리 결과가 단일행)  = > >= < <= != 사용가능
--                 (2)   다중행 서브쿼리(서브쿼리 결과가 다중행)  IN ANY ALL EXISTS 사용가능
-- SCOTT이 근무하는 부서이름 출력
SELECT DNAME,ENAME
        FROM EMP E, DEPT D
                WHERE E.DEPTNO=D.DEPTNO
                        AND ENAME = 'SCOTT';
SELECT DEPTNO 
        FROM EMP 
        WHERE ENAME='SCOTT';   -- 서브쿼리
SELECT DNAME 
        FROM DEPT
        WHERE DEPTNO=(
                                        SELECT DEPTNO 
                                        FROM EMP 
                                        WHERE ENAME='SCOTT'
                                );   -- 메인쿼리
                                        
                                        
-- JOB이 'MANAGER'인 사람의 부서이름
SELECT DEPTNO 
        FROM EMP 
        WHERE JOB ='MANAGER';   -- 다중행서브쿼리
        
SELECT DNAME 
        FROM DEPT
        WHERE DEPTNO IN(
                                        SELECT DEPTNO 
                                        FROM EMP 
                                        WHERE JOB ='MANAGER'
                                        );  -- 메인쿼리 
                                        
-- 2. 단일행 서브쿼리
-- 회사에서 급여를 가장 많이 받는 사람의 이름과 급여를 출력하라
SELECT MAX(SAL) FROM EMP;       -- 서브쿼리(단일행)
SELECT ENAME,SAL
        FROM EMP
        WHERE SAL=(SELECT MAX(SAL) FROM EMP);   -- 메인쿼리
-- SCOTT과 같은 부서번호인 사람이름 출력
SELECT DEPTNO
        FROM EMP
        WHERE ENAME ='SCOTT';
SELECT ENAME
        FROM EMP
        WHERE DEPTNO = (
                                        SELECT DEPTNO
                                        FROM EMP
                                        WHERE ENAME ='SCOTT') 
                AND ENAME !='SCOTT';
-- SCOTT과 같은 근무지인 사람이름 출력 (50번 DALLAS 부서 홍길동 입력 후 진행)
INSERT INTO DEPT VALUES (50,'IT','DALLAS');
INSERT INTO EMP (EMPNO,ENAME,DEPTNO) VALUES (9999,'HONG',50);


SELECT LOC
        FROM DEPT D, EMP E
                WHERE E.DEPTNO = D.DEPTNO
                        AND ENAME ='SCOTT';     -- 서브쿼리

SELECT ENAME 
        FROM EMP E , DEPT D
        WHERE E.DEPTNO =D.DEPTNO
                AND LOC = (
                                SELECT LOC
                                        FROM DEPT D, EMP E
                                        WHERE E.DEPTNO = D.DEPTNO
                                                AND ENAME ='SCOTT'
                                        )
                AND ENAME !='SCOTT';

-- SCOTT과 같은 부서에 근무하는 사람들의 급여 합을 출력
SELECT DEPTNO
        FROM EMP
                WHERE ENAME='SCOTT';   -- 서브쿼리
SELECT SUM(SAL)
        FROM EMP
                WHERE DEPTNO = (
                                                SELECT DEPTNO
                                                FROM EMP
                                                WHERE ENAME='SCOTT'
                );      -- 메인쿼리
-- SCOTT과 동일한 JOB을 가진 사원의 모든 정보를 출력
SELECT * FROM EMP
        WHERE JOB=(
                                SELECT JOB
                                        FROM EMP
                                        WHERE ENAME ='SCOTT'
                                        )
                        AND ENAME !='SCOTT';
                        
-- DALLAS에서 근무하는 사원의 이름, 부서번호를 입력
ROLLBACK;       -- DML 명령어 취소
SELECT ENAME , DEPTNO
        FROM EMP
        WHERE DEPTNO=(
                                SELECT DEPTNO
                                        FROM DEPT
                                        WHERE LOC = 'DALLAS');
-- SALES 부서에 근무하는 직원의 이름, 급여 출력
SELECT ENAME , SAL
        FROM EMP
                WHERE DEPTNO=(
                                                SELECT DEPTNO
                                                        FROM DEPT
                                                        WHERE DNAME='SALES'
                                                );
-- 'KING'이 직속상사인 사원의 이름과 급여
SELECT ENAME ,SAL
        FROM EMP
        WHERE MGR =(
                                SELECT EMPNO
                                        FROM EMP
                                        WHERE ENAME ='KING'
                                );
-- 평균 급여 이하를 받는 사원의 이름, 급여 출력
SELECT ENAME , SAL
        FROM EMP
        WHERE SAL<=(
                                SELECT AVG(SAL)
                                        FROM EMP
                                );
-- SCOTT과 JOB과 부서번호가 같은 직원의 모든 필드 출력(다중열서브쿼리)
SELECT * FROM EMP
        WHERE (JOB,DEPTNO) = (
                                                SELECT JOB,DEPTNO
                                                        FROM EMP
                                                        WHERE ENAME ='SCOTT'
                                                )
                                        AND ENAME !='SCOTT';


-- ★ 단일행 연습문제
--1. 사원테이블에서 가장 먼저 입사한 사람의 이름, 급여, 입사일
SELECT ENAME ,SAL ,HIREDATE
        FROM EMP
        WHERE HIREDATE = (SELECT MIN(HIREDATE)FROM EMP);
-- 2. 회사에서 가장 급여가 적은 사람의 이름, 급여
SELECT ENAME, SAL
        FROM EMP
        WHERE SAL = (SELECT MIN(SAL)FROM EMP);
-- 3. 회사 평균보다 급여를 많이 받는 사람의 이름, 급여, 부서코드
SELECT ENAME, SAL ,DEPTNO
        FROM EMP
        WHERE SAL> (SELECT AVG(SAL)FROM EMP);
--4. 회사 평균 이하의 급여를 받는 사람의 이름, 급여, 부서명
SELECT ENAME ,SAL ,DNAME
        FROM EMP E, DEPT D
        WHERE E.DEPTNO=D.DEPTNO
                AND SAL<(SELECT AVG(SAL)FROM EMP);
--5. SCOTT보다 먼저 입사한 사람의 이름, 급여, 입사일, 급여 등급
SELECT ENAME ,SAL,HIREDATE, GRADE
        FROM EMP, SALGRADE
        WHERE SAL BETWEEN LOSAL AND HISAL
                AND HIREDATE<(SELECT HIREDATE FROM EMP WHERE ENAME='SCOTT');
--6. 5번(SCOTT보다 먼저 입사한 사람의 이름, 급여, 입사일, 급여 등급)에 부서명 추가하고 
    --급여가 큰 순 정렬
SELECT ENAME ,SAL,HIREDATE, GRADE , DNAME
        FROM EMP E, SALGRADE , DEPT D
        WHERE SAL BETWEEN LOSAL AND HISAL
                AND E.DEPTNO =D.DEPTNO
                AND HIREDATE<(SELECT HIREDATE FROM EMP WHERE ENAME='SCOTT')
                        ORDER BY SAL DESC;
--7. 사원테이블에서 BLAKE 보다 급여가 많은 사원들의 사번, 이름, 급여를 검색
SELECT EMPNO , ENAME ,SAL
        FROM EMP
        WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');
--8. 사원테이블에서 MILLER보다 늦게 입사한 사원의 사번, 이름, 입사일을 검색하시오
SELECT EMPNO , ENAME ,HIREDATE
        FROM EMP
        WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME ='MILLER');
--9. 사원테이블에서 사원전체 평균 급여보다 급여가 많은 사원들의 사번, 이름, 급여를 검색
SELECT EMPNO , ENAME , SAL
        FROM EMP
        WHERE SAL > (SELECT AVG(SAL) FROM EMP);
--10. 사원테이블에서 CLARK와 같은 부서며, 사번이 7698인 직원의 급여보다 
        -- 많은 급여를 받는 사원들의 사번, 이름, 급여 검색
SELECT EMPNO , ENAME , SAL
        FROM EMP
        WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'CLARK' )
                AND SAL > (SELECT SAL FROM EMP WHERE EMPNO =7698)
                AND ENAME !='CLARK';

--11.  응용심화. 사원테이블에서 CLARK와 같은 부서명이며, 사번이 7698인 직원의 급여보다 
    --  많은 급여를 받는 사원들의 사번, 이름, 급여 검색
SELECT EMPNO , ENAME , SAL
        FROM EMP E, DEPT D
        WHERE E.DEPTNO =D.DEPTNO
                AND DNAME = (SELECT DNAME FROM EMP A,DEPT B WHERE A.DEPTNO=B.DEPTNO AND ENAME = 'CLARK' )
                AND SAL > (SELECT SAL FROM EMP WHERE EMPNO =7698)
                AND ENAME !='CLARK';

--12.  사원 테이블에서 BLAKE와 같은 부서에 있는 모든 사원의 이름과 입사일자를 출력하는 SELECT문을 작성하시오.
SELECT ENAME , HIREDATE
        FROM EMP
                WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'BLAKE');

--13.  사원 테이블에서 평균 급여 이상을 받는 모든 종업원에 대해서 사원번호와 이름을 출력
        --(단 급여가 많은 순으로 출력하여라.)

SELECT EMPNO , ENAME
        FROM EMP
        WHERE SAL >= (SELECT AVG(SAL) FROM EMP)
                ORDER BY SAL DESC;
                
        
        
-- 3. 다중행 서브쿼리 ; IN, ALL, ANY=SOME, EXISTS
-- (1) IN ; 서브쿼리 결과 중 하나라도 일치하면 참
-- 부서별로 입사일이 가장 늦은 사람의 부서번호,이름, 입사일 출력
SELECT DEPTNO, MAX(HIREDATE) FROM EMP GROUP BY DEPTNO;   -- 서브 쿼리
SELECT DEPTNO , ENAME ,HIREDATE 
        FROM EMP
        WHERE (DEPTNO,HIREDATE) IN(SELECT DEPTNO, MAX(HIREDATE) FROM EMP GROUP BY DEPTNO);
-- 급여를 3000이상 받는 사원이 소속된 부서에서 근무하는 사원들의 모든 정보 
SELECT * FROM EMP
        WHERE DEPTNO IN (SELECT  DEPTNO FROM EMP WHERE SAL>=3000);

-- (2) ALL
-- 30번 부서 최대 급여보다 급여를 더 많이 받는 사람의 정보
SELECT * FROM EMP
        WHERE SAL>(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP
        WHERE SAL>ALL(SELECT SAL FROM EMP WHERE DEPTNO=30);

-- (3) ANY=SOME
SELECT * FROM EMP
        WHERE SAL >(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);
SELECT * FROM EMP
        WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);

-- (4) EXISTS ; 서브쿼리의 결과가 존재하면 참
-- 직속부하가 있는 직원들의 사번, 이름 ,급여 출력
SELECT EMPNO , ENAME, SAL
        FROM EMP M
        WHERE EXISTS (SELECT * FROM EMP WHERE M.EMPNO=MGR);
-- 말단사원의 모든 필드 정보 출력
SELECT * FROM EMP M
        WHERE NOT EXISTS (SELECT * FROM EMP WHERE M.EMPNO=MGR); 
        
-- 탄탄다지기

-- 부서별로 가장 급여를 많이 받는 사원의 사번, 이름 ,급여 ,부서번호
SELECT EMPNO, ENAME, SAL ,DEPTNO
        FROM EMP
        WHERE (DEPTNO,SAL) IN  (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- 직급(JOB)이 MANAGER인 사람의 속한 부서의 부서 번호와 부서명과 지역을 출력(IN)
SELECT DEPTNO , DNAME, LOC
        FROM DEPT 
        WHERE DEPTNO IN(SELECT DEPTNO FROM EMP WHERE JOB='MANAGER');
-- 연봉이 3000이상인 사람들 중 연봉 등급을 나누어서 해당 등급별 최고 연봉을 받는 사람들의 사번, 이름, 직업, 입사일, 급여, 급여등급을 출력
SELECT EMPNO , ENAME , JOB ,HIREDATE, SAL, GRADE
        FROM EMP, SALGRADE
                WHERE SAL BETWEEN LOSAL AND HISAL
                        AND SAL>=3000
                        AND (GRADE,SAL) IN(SELECT GRADE,MAX(SAL) 
                                                        FROM EMP,SALGRADE 
                                                        WHERE SAL BETWEEN LOSAL AND HISAL 
                                                                GROUP BY GRADE)
                                        ORDER BY GRADE;                                                                                                                                                       
-- 응용심화 : 입사일 분기별로 가장 높은 연봉을 받는 사람들의 분기, 사번, 이름, JOB, 상사사번, 입사일, 급여, 상여를 출력하세요
SELECT HIREDATE, CEIL(EXTRACT(MONTH FROM HIREDATE)/3) QUARTER FROM EMP;




SELECT CEIL(EXTRACT(MONTH FROM HIREDATE)/3) QUARTER ,EMPNO, ENAME ,JOB , MGR, HIREDATE,SAL,NVL(COMM,0) 상여
        FROM EMP
                WHERE SAL IN(SELECT MAX(SAL) FROM EMP WHERE TO_CHAR(HIREDATE,'MM') BETWEEN 01 AND 03)
                        OR SAL IN(SELECT MAX(SAL) FROM EMP WHERE TO_CHAR(HIREDATE,'MM') BETWEEN 04 AND 06)
                        OR SAL IN(SELECT MAX(SAL) FROM EMP WHERE TO_CHAR(HIREDATE,'MM') BETWEEN 07 AND 09)
                        OR SAL IN(SELECT MAX(SAL) FROM EMP WHERE TO_CHAR(HIREDATE,'MM') BETWEEN 10 AND 12)
                                ORDER BY QUARTER;
                
-- SALESMAN 모든 사원들 보다 급여를 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력하되 영업 사원은 출력하지 않는다.(ALL이용)
SELECT ENAME ,SAL,JOB 
        FROM EMP
        WHERE SAL> ALL(SELECT SAL FROM EMP WHERE JOB= 'SALESMAN')
                AND JOB != 'SALESMAN';
-- SALESMAN 일부 어떤 한 사원보다 급여를 많이 받는 사원들의 이름과 급여와 직급(담당 업무)를 출력하되 영업 사원은 출력(ANY)
SELECT ENAME,SAL ,JOB 
        FROM EMP
        WHERE SAL> ANY(SELECT SAL FROM EMP WHERE JOB= 'SALESMAN')	;
--연봉이 3000미만인 사람 중에 가장 최근에 입사한 사람의 사원번호와 이름, 연봉, 입사일을 출력
SELECT EMPNO , ENAME, SAL , HIREDATE
        FROM EMP
        WHERE HIREDATE IN (SELECT MAX(HIREDATE) FROM EMP WHERE SAL <3000 );
--직급이 ‘SALESMAN’인 사원이 받는 급여의 최소 급여보다 많이 받는 사원들의 이름, 급여, 직급, 부서번호를 출력하되 부서번호가 20번인 사원은 제외한다(ANY 연산자 이용)
SELECT ENAME ,SAL ,JOB ,DEPTNO 
        FROM EMP
        WHERE SAL > ANY(SELECT SAL FROM EMP WHERE JOB ='SALESMAN')
                AND DEPTNO != 20;
                
-- 다중행서브쿼리 연습문제
-- 14. 사원 테이블에서 이름에 “T”가 있는 사원이 근무하는 부서에서 근무하는 모든 종업원에 대해
    --사원 번호,이름,급여를 출력하는 SELECT문을 작성하시오. 단 사원번호 순으로 출력하여라.
SELECT EMPNO , ENAME, SAL
        FROM EMP
                WHERE DEPTNO IN (SELECT DEPTNO FROM EMP WHERE ENAME LIKE '%T%')
                        ORDER BY EMPNO; 
-- 15. 사원 테이블에서 부서 위치가 Dallas인 모든 종업원에 대해 이름,업무,급여를 출력
SELECT ENAME , JOB ,SAL
        FROM EMP 
                 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
-- 16. EMP 테이블에서 King에게 보고하는 모든 사원의 이름과 급여를 출력하는 SELECT문
SELECT ENAME ,SAL
        FROM EMP
                WHERE MGR = (SELECT EMPNO FROM EMP WHERE ENAME ='KING');
-- 17. 사원 테이블에서 SALES부서 사원의 이름,업무를 출력하는 SELECT문을 작성하시오.
SELECT ENAME,JOB
        FROM EMP E, DEPT D
                WHERE E.DEPTNO =D.DEPTNO
                        AND DNAME =(SELECT DNAME FROM DEPT WHERE DNAME ='SALES');
-- 18. 사원 테이블에서 월급이 부서 30의 최저 월급보다 높은 사원을 출력
SELECT * FROM EMP
        WHERE SAL>ANY(SELECT SAL FROM EMP WHERE DEPTNO=30);
       
SELECT * FROM EMP
        WHERE SAL>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);
-- 19. 부서 10에서 부서 30의 사원과 같은 업무를 맡고 있는 사원의 이름과 업무를 출력
SELECT ENAME, JOB
        FROM EMP
                WHERE DEPTNO= 10
                AND JOB IN (SELECT JOB FROM EMP WHERE DEPTNO=30);
-- 20. 사원 테이블에서 FORD와 업무도 월급도 같은 사원의 모든 정보를 출력
SELECT * FROM EMP
        WHERE (SAL,JOB) IN (SELECT SAL,JOB FROM EMP WHERE ENAME = 'FORD')
                AND ENAME =  'FORD';
-- 21. 이름이 JONES인 직원의 JOB과 같거나 
    --월급이 FORD 월급 이상인 사원의 정보를 이름,업무,부서번호,급여를 출력하는 SELECT문을 작성.
    -- 단, 업무별 알파벳 순, 월급이 많은 순으로 출력하여라.
SELECT ENAME, JOB ,DEPTNO, SAL
        FROM EMP
                WHERE JOB = (SELECT JOB FROM EMP WHERE ENAME ='JONES')
                        OR SAL>(SELECT SAL FROM EMP WHERE ENAME='FORD')
                                ORDER BY ENAME,SAL DESC;
-- 22. 사원 테이블에서 SCOTT 또는 WARD와 월급이 같은 사원의 정보를 이름,업무,급여를 출력하는 SELECT문을 작성하시오.
SELECT ENAME,JOB,SAL 
        FROM EMP
                WHERE SAL IN(SELECT SAL FROM EMP WHERE ENAME='SCOTT' OR ENAME = 'WARD')
                        AND ENAME !='SCOTT' AND ENAME !='WARD';
-- 23. 사원 테이블에서 CHICAGO에서 근무하는 사원과 같은 업무를 하는 사원들의 이름,업무를 출력하는 SELECT문을 작성하시오.
SELECT ENAME, JOB
        FROM EMP
                WHERE JOB IN(SELECT JOB FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO AND LOC = 'CHICAGO');
-- 24. 사원 테이블에서 부서별로 월급이 평균 월급보다 높은 사원을 사원번호,이름,급여를 출력하는 SELECT문을 작성하시오.
SELECT EMPNO , ENAME , SAL
        FROM EMP
                WHERE EMPNO IN(SELECT EMPNO
                                                FROM EMP
                                                WHERE SAL > (SELECT AVG(SAL)  FROM EMP WHERE DEPTNO=10)
                                                AND DEPTNO= 10)
                        OR  EMPNO IN(SELECT EMPNO
                                                FROM EMP
                                                WHERE SAL > (SELECT AVG(SAL)  FROM EMP WHERE DEPTNO=20)
                                                AND DEPTNO= 20)
                        OR  EMPNO IN(SELECT EMPNO
                                                FROM EMP
                                                WHERE SAL > (SELECT AVG(SAL)  FROM EMP WHERE DEPTNO=30)
                                                AND DEPTNO= 30);
                                                
SELECT EMPNO, ENAME, SAL
        FROM EMP E
                WHERE SAL>(SELECT AVG(SAL) FROM EMP WHERE DEPTNO =E.DEPTNO);
-- 25. 사원 테이블에서 각 업무별 월급이 각 업무별 평균 월급보다 낮은 사원을 부서번호,이름,급여를 출력하는 SELECT문을 작성하시오.
SELECT DEPTNO, ENAME,SAL
        FROM EMP E
                WHERE SAL<(SELECT AVG(SAL)FROM EMP WHERE JOB=E.JOB);
-- 26 사원 테이블에서 적어도 한 명 이상으로부터 보고를 받을 수 있는 사원을 업무,이름,사원번호,부서번호를 출력(단, 부서번호 순으로 오름차순 정렬)
SELECT JOB , ENAME, EMPNO, DEPTNO
        FROM EMP M
                WHERE EXISTS(SELECT EMPNO FROM EMP W WHERE  M.EMPNO=W.MGR)
                        ORDER BY DEPTNO ;

-- 27. 사원 테이블에서 말단 사원의 사원번호, 이름, 업무, 부서번호를 출력하는 SELECT문을 작성하시오.
SELECT EMPNO , ENAME , JOB ,DEPTNO
        FROM EMP M
                WHERE NOT EXISTS(SELECT EMPNO FROM EMP W WHERE M.EMPNO = W.MGR);
