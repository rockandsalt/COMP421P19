DROP TABLE IF EXISTS Members CASCADE;
DROP TABLE IF EXISTS Plans CASCADE;
DROP TABLE IF EXISTS Memberships CASCADE;
DROP TABLE IF EXISTS Classes CASCADE;
DROP TABLE IF EXISTS Instructors CASCADE;
DROP TABLE IF EXISTS InstructorEnroll CASCADE;
DROP TABLE IF EXISTS Qualifications CASCADE;
DROP TABLE IF EXISTS hasQ CASCADE;
DROP TABLE IF EXISTS Bills CASCADE;
DROP TABLE IF EXISTS PaymentInfo CASCADE;
DROP TABLE IF EXISTS Pays CASCADE;
DROP TABLE IF EXISTS ClassEnroll CASCADE;

CREATE TABLE Members(
mid SERIAL PRIMARY KEY,
mname TEXT,
HouseNum INTEGER,
Street TEXT ,
City TEXT,
PostalCode VARCHAR(8),
phone VARCHAR(12),
regidate DATE
);


CREATE TABLE Plans(
pname VARCHAR(20) PRIMARY KEY NOT NULL,
cost MONEY  NOT NULL,
payment_frequency INTEGER NOT NULL
);


CREATE TABLE Memberships(
MemberId INTEGER PRIMARY KEY REFERENCES Members(mid),
pname VARCHAR(20) NOT NULL REFERENCES Plans(pname),
pregidate DATE
);

CREATE TABLE Instructors(
InstructorID SERIAL PRIMARY KEY,
InstructorName TEXT);

CREATE TABLE Classes(
CId SERIAL NOT NULL PRIMARY KEY,
Cname TEXT  NOT NULL,
CFrequency VARCHAR(7) NOT NULL,
CFirstDAY DATE NOT NULL ,
CTime TIME NOT NULL,
CDuration FLOAT NOT NULL,
CMaxEnroll INTEGER,
CRoom VARCHAR(10),
TaughtBy INTEGER NOT NULL REFERENCES Instructors(InstructorID)
);


CREATE TABLE ClassEnroll(
mid INTEGER NOT NULL REFERENCES Members(mid),
classID INTEGER NOT NULL REFERENCES Classes(CId),
PRIMARY KEY(mid, classID ));



CREATE TABLE InstructorEnroll(
mid INTEGER NOT NULL REFERENCES Members(mid),
InID INTEGER NOT NULL REFERENCES Instructors(InstructorID),
PRIMARY KEY (mid,InID)
);

CREATE TABLE Qualifications(qname TEXT PRIMARY KEY NOT NULL);

CREATE TABLE hasQ(
InID INTEGER NOT NULL REFERENCES Instructors(InstructorID),
qname TEXT NOT NULL REFERENCES Qualifications(qname),
qlevel INTEGER CHECK(qlevel >0 AND qlevel<11),
PRIMARY KEY(InID,qname)
);

CREATE TABLE Bills(
BillID SERIAL PRIMARY KEY,
Amount MONEY NOT NULL,
PName VARCHAR(20) NOT NULL REFERENCES Plans(pname),
BillGenerationDate TIMESTAMP DEFAULT current_timestamp, 
MemberID INTEGER  NOT NULL REFERENCES Members(mid),
Payment_Deadline TIMESTAMPTZ 
);

CREATE TABLE Pays(
PaymentID SERIAL,
DatePayment TIMESTAMPTZ,
BillID INTEGER PRIMARY KEY REFERENCES Bills(BillID),
MId INTEGER REFERENCES Members(mid)
);



CREATE TABLE PaymentInfo(
cardNumber INTEGER,
billingAddress TEXT,
cardtype VARCHAR(10),
cardowner TEXT,
Member INTEGER NOT NULL REFERENCES Members(mid),
PRIMARY KEY (cardNumber, Member)
);




 

























