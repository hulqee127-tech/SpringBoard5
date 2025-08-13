CREATE   TABLE   TUSER (
     USERID      VARCHAR2(12)  PRIMARY KEY
   , PASSWD      VARCHAR2(12)  NOT NULL
   , USERNAME    VARCHAR2(30)  NOT NULL
   , EMAIL       VARCHAR2(320)
   , UPOINT      NUMBER(10)    DEFAULT 0  
   , INDATE      DATE          DEFAULT SYSDATE
);

INSERT INTO tuser (
    userid,
    passwd,
    username,
    email,
    upoint,
    indate
) VALUES (
    'admin',
    '1234',
    '관리자',
    'admin@green.com',
    1000,
    sysdate
);

commit;
