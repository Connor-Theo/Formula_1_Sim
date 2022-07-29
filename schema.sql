-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "f1_data" (
    "full_name" Varchar   NOT NULL,
    "driverId" Integer   NOT NULL,
    "race_name" Varchar   NOT NULL,
    "raceId" integer   NOT NULL,
    "date" date   NOT NULL,
    "grid_position" integer   NOT NULL,
    "finish_position" integer   NOT NULL,
    "avg_humidity" float   NOT NULL,
    "avg_air_pressure" float   NOT NULL,
    "rainfall" bool   NOT NULL,
    "avg_airtemp" float   NOT NULL,
    "safety_car_laps" integer   NOT NULL,
    "redflag" integer   NOT NULL,
    "total_lap_time" time   NOT NULL,
    "downforce_level" text   NOT NULL,
    "longest_flat_out" integer   NOT NULL,
    "first_stop" integer   NOT NULL,
    "start_tyre" varchar   NOT NULL,
    "end_tyre" varchar   NOT NULL,
    "num_stops" integer   NOT NULL,
    CONSTRAINT "pk_f1_data" PRIMARY KEY (
        "driverId"
     )
);

CREATE TABLE "drivers" (
    "driverId" integer   NOT NULL,
    "driverRef" varchar   NOT NULL,
    "code" char(3)   NOT NULL,
    "forename" varchar   NOT NULL,
    "surname" varchar   NOT NULL,
    "FullName" Varchar   NOT NULL,
    CONSTRAINT "pk_drivers" PRIMARY KEY (
        "driverId"
     )
);

CREATE TABLE "lap_time" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "lap" integer   NOT NULL,
    "position" integer   NOT NULL,
    "time" timestamp   NOT NULL,
    "milliseconds" integer   NOT NULL,
    CONSTRAINT "pk_lap_time" PRIMARY KEY (
        "driverId"
     )
);

CREATE TABLE "circuits" (
    "circuitId" integer   NOT NULL,
    "circuitRef" Varchar   NOT NULL,
    "name" Varchar   NOT NULL,
    "location" Varchar   NOT NULL,
    "country" Varchar   NOT NULL,
    "lat" integer   NOT NULL,
    "lng" integer   NOT NULL,
    "alt" integer   NOT NULL,
    CONSTRAINT "pk_circuits" PRIMARY KEY (
        "circuitId"
     )
);

CREATE TABLE "pit_stops" (
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "stop" integer(1)   NOT NULL,
    "lap" integer   NOT NULL,
    "time" interval   NOT NULL,
    "duration" interval   NOT NULL,
    "millisecond" integer   NOT NULL,
    CONSTRAINT "pk_pit_stops" PRIMARY KEY (
        "raceId"
     )
);

CREATE TABLE "race" (
    "raceId" integer   NOT NULL,
    "year" integer   NOT NULL,
    "round" integer   NOT NULL,
    "circuitId" integer   NOT NULL,
    "race_name" varchar   NOT NULL,
    "date" date   NOT NULL,
    "time" interval   NOT NULL,
    "fp1_date" date   NOT NULL,
    "fp1_time" interval   NOT NULL,
    "fp2_date" date   NOT NULL,
    "fp2_time" interval   NOT NULL,
    "fp3_date" date   NOT NULL,
    "fp3_time" interval   NOT NULL,
    "quali_date" date   NOT NULL,
    "quali_time" interval   NOT NULL,
    "sprint_date" date   NOT NULL,
    "sprint_time" interval   NOT NULL,
    CONSTRAINT "pk_race" PRIMARY KEY (
        "raceId"
     )
);

CREATE TABLE "results" (
    "resultId" int   NOT NULL,
    "raceId" integer   NOT NULL,
    "driverId" integer   NOT NULL,
    "constructorId" integer   NOT NULL,
    "number" integer   NOT NULL,
    "grid" integer   NOT NULL,
    "finish_Position" integer   NOT NULL,
    "positionText" text   NOT NULL,
    "positionOrder" integer   NOT NULL,
    "points" integer   NOT NULL,
    "laps" integer   NOT NULL,
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

