use TESTDB
go

set statistics time ON

insert into dbo.TEST_TABLE(TEST_FIELD1) values ('hello')
insert into dbo.TEST_TABLE(TEST_FIELD1) values ('world')

go