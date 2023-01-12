# sybase statsd

## configure send udp paket

### setup
```sql
sp_configure 'allow sendmsg', 1
go
```

### send metrics
```sql
sp_sendmsg "host.docker.internal", 8125, "sybase.hello:10|c"
go
```