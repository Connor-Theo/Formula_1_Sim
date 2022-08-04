-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- LOOK AT ADDING COMPOSITE KEY
CREATE TABLE "modeling_data" (
    "full_name" Varchar   NOT NULL,
    "driverId" Integer   NOT NULL,
    "race_name" Varchar   NOT NULL,
    "raceId" integer   NOT NULL,
    "date" date   NOT NULL,
    "grid_position" integer   NOT NULL,
    "finish_position" integer   NOT NULL,
    "avg_humidity" float   NOT NULL,
    "avg_air_pressure" float   NOT NULL,
    "rainfall" boolean   NOT NULL,
    "avg_airtemp" float   NOT NULL,
    "safety_car_laps" integer(2)   NOT NULL,
    "redflag" integer(1)   NOT NULL,
    "total_lap_time" interval   NOT NULL,
    "downforce_level" varchar(12)   NOT NULL,
    "longest_flat_out" integer   NOT NULL,
    "first_stop" integer   NOT NULL,
    "start_tyre" varchar(13)   NOT NULL,
    "end_tyre" varchar(13)   NOT NULL,
    "num_stops" integer   NOT NULL,
    CONSTRAINT "pk_f1_data" PRIMARY KEY (
        "driverId"
     )
);

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

CREATE TABLE "lap_time" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "lap" integer   NOT NULL,
    "position" integer   NOT NULL,
    "time" interval   NOT NULL,
    "milliseconds" integer   NOT NULL,
    CONSTRAINT "pk_lap_time" PRIMARY KEY (
        "raceId", "driverId", "lap"
     )
);

CREATE TABLE "circuits" (
    "circuitId" integer   NOT NULL,
    "circuitRef" Varchar(20)   NOT NULL,
    "name" Varchar(40)   NOT NULL,
    "location" Varchar(22)   NOT NULL,
    "country" Varchar   NOT NULL,
    "lat" float   NOT NULL,
    "lng" float   NOT NULL,
    "alt" integer   NOT NULL,
    CONSTRAINT "pk_circuits" PRIMARY KEY (
        "circuitId"
     )
);
LOOK AT ADDING COMPOSITE KEY
CREATE TABLE "pit_stops" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "stop" integer(1)   NOT NULL,
    "lap" integer(2)   NOT NULL,
    "time" interval   NOT NULL,
    "duration" interval   NOT NULL,
    "milliseconds" integer(6)   NOT NULL,
    CONSTRAINT "pk_pit_stops" PRIMARY KEY (
        "raceId"
     )
);

CREATE TABLE "race" (
    "raceId" integer   NOT NULL,
    "year" integer   NOT NULL,
    "round" integer   NOT NULL,
    "circuitId" integer   NOT NULL,
    "race_name" varchar(30)   NOT NULL,
    "date" date   NOT NULL,
    "time" timestamp   NOT NULL,
    "fp1_date" date   NOT NULL,
    "fp1_time" timestamp   NOT NULL,
    "fp2_date" date   NOT NULL,
    "fp2_time" timestamp   NOT NULL,
    "fp3_date" date   NOT NULL,
    "fp3_time" timestamp   NOT NULL,
    "quali_date" date   NOT NULL,
    "quali_time" timestamp   NOT NULL,
    "sprint_date" date   NOT NULL,
    "sprint_time" timestamp   NOT NULL,
    CONSTRAINT "pk_race" PRIMARY KEY (
        "raceId"
     )
);

CREATE TABLE "results" (
    "resultId" integer   NOT NULL,
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "constructorId" integer   NOT NULL,
    "number" integer   NOT NULL,
    "grid" integer   NOT NULL,
    "finish_Position" integer   NOT NULL,
    "positionText" text   NOT NULL,
    "positionOrder" integer   NOT NULL,
    "points" integer(2)   NOT NULL,
    "laps" integer(2)   NOT NULL,
    "time" interval   NOT NULL,
    "milliseconds" integer   NOT NULL,
    "fastestLapTime" interval   NOT NULL,
    "fastestLapSpeed" integer   NOT NULL,
    "statusID" integer   NOT NULL,
    CONSTRAINT "pk_results" PRIMARY KEY (
        "resultId"
     )
);

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

