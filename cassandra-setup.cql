-- For hadoop
drop keyspace if exists hadoop;
create keyspace hadoop WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};
use hadoop;

CREATE TABLE state_mmr (
                           mmr DOUBLE,
                           state TEXT,
                           PRIMARY KEY (state)
);

-- For spark
drop keyspace if exists spark;
create keyspace spark WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 1};
use spark;

CREATE TABLE city_enroll (
                             city TEXT,
                             enroll INT,
                             PRIMARY KEY (city)
)