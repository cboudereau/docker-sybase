# sybase statsd

## run the demo
```bash
cd examples/observability

docker compose down --remove-orphans -v --rmi local && docker compose up
```

go to [prometheus dashboard and observe the percentile metrics](http://localhost:9090/graph?g0.expr=sybase_test_table_insert&g0.tab=0&g0.stacked=1&g0.show_exemplars=0&g0.range_input=1h&g0.step_input=1)

## configure send udp paket from sybase

### setup
```sql
sp_configure 'allow sendmsg', 1
go
```

### send metrics example 
```sql
sp_sendmsg "host.docker.internal", 8125, "sybase.hello:10|c"
go
```