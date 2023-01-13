use TESTDB
go

set statistics time ON

/* Tradeoff : measure delay with datetime (no support for ticks nor timestamp nor true stopwatch, precision is 1/300 second). Ok to measure high latencies ie : > 1s */
declare @s datetime
select @s = GETUTCDATE()

insert into dbo.TEST_TABLE(TEST_FIELD1) values ('1')
insert into dbo.TEST_TABLE(TEST_FIELD1) values ('1')
insert into dbo.TEST_TABLE(TEST_FIELD1) values ('1')
insert into dbo.TEST_TABLE(TEST_FIELD1) values ('1')
insert into dbo.TEST_TABLE(TEST_FIELD1) values ('1')

declare @e datetime
select @e = GETUTCDATE()

declare @t integer
select @t = DATEDIFF(MILLISECOND, @s, @e)

declare @msg varchar(255)
select @msg = "sybase.test_table.insert:" + convert(varchar, @t) + "|ms"
exec sp_sendmsg "statsd", 8125, @msg

select count(*) from dbo.TEST_TABLE

go