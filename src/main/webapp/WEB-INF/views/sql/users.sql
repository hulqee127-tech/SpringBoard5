CREATE   TABLE   TUSER (
     USERID      VARCHAR2(12)  PRIMARY KEY
   , PASSWD      VARCHAR2(12)  NOT NULL
   , USERNAME    VARCHAR2(30)  NOT NULL
   , EMAIL       VARCHAR2(320)
   , UPOINT      NUMBER(10)    DEFAULT 0  
   , INDATE      DATE          DEFAULT SYSDATE
);

INSERT INTO TUSER  VALUES ('admin', '1234', '관리자', 'admin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user1', '1234', '놘리자', 'bdmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user2', '1234', '돤리자', 'cdmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user3', '1234', '롼리자', 'ddmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user4', '1234', '뫈리자', 'edmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user5', '1234', '봔리자', 'fdmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user6', '1234', '솬리자', 'gdmin@green.com', 1000, sysdate );
INSERT INTO TUSER  VALUES ('user7', '1234', '완리자', 'hdmin@green.com', 1000, sysdate );

commit;