﻿-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

drop table modeling_data
CREATE TABLE "modeling_data" (
    "full_name" Varchar   NOT NULL,
    "driverId" Integer   NOT NULL,
    "race_name" Varchar   NOT NULL,
    "raceId" integer   NOT NULL,
    "date" date   NOT NULL,
    "grid_position" integer   NOT NULL,
    "finish_position" integer,
    "avg_humidity" float   NOT NULL,
    "avg_air_pressure" float   NOT NULL,
    "rainfall" boolean   NOT NULL,
    "avg_airtemp" float   NOT NULL,
    "safety_car_laps" integer  NOT NULL,
    "redflag" integer   NOT NULL,
    "total_lap_time" float,
    "downforce_level" varchar(12),
    "longest_flat_out" integer,
    "first_stop" integer,
    "start_tyre" varchar(13),
    "end_tyre" varchar(13),
    "num_stops" integer,
    CONSTRAINT "pk_f1_data" PRIMARY KEY (
        "driverId", "raceId"
     )
);

COPY modeling_data
FROM 'D:\Prof_Dev\Git\Formula_1_Sim\Resources\modeling_data.csv'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "drivers" (
    "driverId" integer   NOT NULL,
    "driverRef" varchar(18)   NOT NULL,
    "code" char(3)   NOT NULL,
    "forename" varchar(10)   NOT NULL,
    "surname" varchar(10)   NOT NULL,
    "FullName" Varchar(18)   NOT NULL,
    CONSTRAINT "pk_drivers" PRIMARY KEY (
        "driverId"
     )
);

COPY drivers
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "lap_time" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "lap" integer   NOT NULL,
    "position" integer   NOT NULL,
    "time" time     NOT NULL,
    "milliseconds" integer   NOT NULL,
    CONSTRAINT "pk_lap_time" PRIMARY KEY (
        "raceId", "driverId", "lap"
     )
);

COPY lap_time
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "circuits" (
    "circuitId" integer   NOT NULL,
    "circuitRef" Varchar(20)   NOT NULL,
    "name" Varchar(40)   NOT NULL,
    "location" Varchar(22)   NOT NULL,
    "country" Varchar   NOT NULL,
    "lat" float   NOT NULL,
    "lng" float   NOT NULL,
    "alt" integer,
    CONSTRAINT "pk_circuits" PRIMARY KEY (
        "circuitId"
     )
);

COPY circuits
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "pit_stops" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "stop" integer   NOT NULL,
    "lap" integer   NOT NULL,
    "time" time   NOT NULL,
    "duration" float   NOT NULL,
    "milliseconds" integer   NOT NULL,
    CONSTRAINT "pk_pit_stops" PRIMARY KEY (
        "raceId", "driverId", "lap"
     )
);

COPY pit_stops
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "race" (
    "raceId" integer   NOT NULL,
    "year" integer   NOT NULL,
    "round" integer   NOT NULL,
    "circuitId" integer   NOT NULL,
    "race_name" varchar(30)   NOT NULL,
    "date" date   NOT NULL,
    "time" time,
    "fp1_date" date,
    "fp1_time" time,
    "fp2_date" date,
    "fp2_time" time,
    "fp3_date" date,
    "fp3_time" time,
    "quali_date" date,
    "quali_time" time,
    "sprint_date" date,
    "sprint_time" time,
    CONSTRAINT "pk_race" PRIMARY KEY (
        "raceId"
     )
);

COPY race
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

CREATE TABLE "results" (
    "resultId" integer   NOT NULL,
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "constructorId" integer   NOT NULL,
    "number" integer,
    "grid" integer   NOT NULL,
    "Finish_Position" integer,
    "positionText" text   NOT NULL,
    "positionOrder" integer   NOT NULL,
    "points" float   NOT NULL,
    "laps" integer   NOT NULL,
    "time" time,
    "milliseconds" integer,
	"fatestLap" integer,
	"rank" integer,
    "fastestLapTime" time,
    "fastestLapSpeed" float,
    "statusID" integer   NOT NULL,
    CONSTRAINT "pk_results" PRIMARY KEY (
        "resultId"
     )
);


COPY results
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;


CREATE TABLE "qualifying" (
    "qualifyId" integer   NOT NULL,
    "raceId" integer   NOT NULL,
	"driverId" integer   NOT NULL,
    "constructorId" integer   NOT NULL,
    "number" integer   NOT NULL,
    "position" integer   NOT NULL,
    "q1" interval,
    "q2" interval,
	"q3" interval,
    CONSTRAINT "pk_qualifying" PRIMARY KEY (
        "qualifyId", "driverId"
     )
);

COPY qualifying
FROM 'your directory here'
DELIMITER ','
NULL AS '\N'
CSV HEADER;

Select md.race_name,
		--md.driverId,
		md.date,
		md.full_name,
		--md.raceId,
		md.finish_position,
		md.grid_position,
		md.avg_humidity,
		md.avg_air_pressure,
		md.rainfall,
		md.avg_airtemp,
		md.downforce_level,
		md.start_tyre,
		md.end_tyre,
		md.num_stops,		
		--q.driverId,
		--q.raceId,		
		q.q1,
		q.q2,
		q.q3
Into sim_data
From modeling_data as md
	inner join qualifying as q
		on (md."raceId" = q."raceId")
			and
		   (md."driverId" = q."driverId")
Order by md.date, md.finish_position;

ALTER TABLE "f1_data" ADD CONSTRAINT "fk_f1_data_raceId" FOREIGN KEY("raceId")
REFERENCES "race" ("raceId");

ALTER TABLE "drivers" ADD CONSTRAINT "fk_drivers_driverId" FOREIGN KEY("driverId")
REFERENCES "f1_data" ("driverId");

ALTER TABLE "lap_time" ADD CONSTRAINT "fk_lap_time_raceId_driverId" FOREIGN KEY("raceId", "driverId")
REFERENCES "f1_data" ("raceId", "driverId");

ALTER TABLE "pit_stops" ADD CONSTRAINT "fk_pit_stops_raceId" FOREIGN KEY("raceId")
REFERENCES "lap_time" ("raceId");

ALTER TABLE "pit_stops" ADD CONSTRAINT "fk_pit_stops_driverId" FOREIGN KEY("driverId")
REFERENCES "f1_data" ("driverId");

ALTER TABLE "race" ADD CONSTRAINT "fk_race_raceId" FOREIGN KEY("raceId")
REFERENCES "lap_time" ("raceId");

ALTER TABLE "race" ADD CONSTRAINT "fk_race_circuitId" FOREIGN KEY("circuitId")
REFERENCES "circuits" ("circuitId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_raceId" FOREIGN KEY("raceId")
REFERENCES "f1_data" ("driverId");

ALTER TABLE "results" ADD CONSTRAINT "fk_results_driverId" FOREIGN KEY("driverId")
REFERENCES "lap_time" ("driverId");

