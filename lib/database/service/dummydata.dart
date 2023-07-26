String csv = """Date,Workout Name,Duration,Exercise Name,Set Order,Weight,Reps,Distance,Seconds,Notes,Workout Notes,RPE
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Running (Treadmill)",1,0,0,0.84,600,"","",0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Climbing",1,0,0,0,300,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Cycling (Indoor)",1,0,0,2.0,600,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Lat Pulldown (Cable)",1,80.0,5,0,0,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Lat Pulldown (Cable)",2,80.0,5,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Lat Pulldown (Cable)",3,80.0,5,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Lat Pulldown (Cable)",4,80.0,5,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Chest Press (Machine)",1,70.0,5,0,0,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Chest Press (Machine)",2,70.0,5,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Chest Press (Machine)",3,70.0,5,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Leg Extension (Machine)",1,70.0,10,0,0,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Leg Extension (Machine)",2,70.0,10,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Seated Leg Curl (Machine)",1,50.0,10,0,0,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Seated Leg Curl (Machine)",2,50.0,10,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Iso-Lateral Row (Machine)",1,90.0,10,0,0,"",,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Iso-Lateral Row (Machine)",2,90.0,10,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Iso-Lateral Row (Machine)",3,90.0,10,0,0,,,0
2022-01-12 12:40:52,"Midday Workout",1h 26m,"Deadlift (Barbell)",1,110.0,3,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Bench Press (Barbell)",1,10.0,10,0,0,"","",0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Bench Press (Barbell)",2,10.0,10,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Bench Press (Barbell)",3,10.0,10,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Fly",1,50.0,8,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Fly",2,50.0,8,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Fly",3,50.0,8,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Triceps Pushdown (Cable - Straight Bar)",1,80.0,10,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Triceps Pushdown (Cable - Straight Bar)",2,80.0,10,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Triceps Pushdown (Cable - Straight Bar)",3,80.0,10,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Triceps Extension (Machine)",1,30.0,10,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Triceps Extension (Machine)",2,30.0,10,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Press (Machine)",1,70.0,5,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Press (Machine)",2,70.0,5,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Chest Press (Machine)",3,70.0,5,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Lat Pulldown (Cable)",1,80.0,5,0,0,"",,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Lat Pulldown (Cable)",2,100.0,5,0,0,,,0
2022-01-18 14:59:02,"Afternoon Workout",35m,"Lat Pulldown (Cable)",3,80.0,5,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Elliptical Machine",1,0,0,0.75,600,"","",0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Cycling (Indoor)",1,0,0,1.0,300,"",,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Bicep Curl (Machine)",1,30.0,10,0,0,"",,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Bicep Curl (Machine)",2,30.0,10,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Bicep Curl (Machine)",3,30.0,10,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Back Extension (Machine)",1,90.0,10,0,0,"",,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Back Extension (Machine)",2,110.0,10,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Back Extension (Machine)",3,130.0,10,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Seated Row (Cable)",1,100.0,10,0,0,"",,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Seated Row (Cable)",2,100.0,5,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Seated Row (Cable)",3,80.0,5,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Seated Row (Cable)",4,80.0,5,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Reverse Fly (Machine)",1,30.0,10,0,0,"",,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Reverse Fly (Machine)",2,30.0,10,0,0,,,0
2022-01-20 14:59:11,"Afternoon Workout",1h 16m,"Reverse Fly (Machine)",3,30.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Fly",1,90.0,5,0,0,"","",0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Fly",2,110.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Fly",3,90.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Fly",4,90.0,4,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Pushdown (Cable - Straight Bar)",1,80.0,10,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Pushdown (Cable - Straight Bar)",2,80.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Pushdown (Cable - Straight Bar)",3,80.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Extension (Machine)",1,50.0,5,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Extension (Machine)",2,30.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Triceps Extension (Machine)",3,30.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Press (Machine)",1,110.0,5,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Press (Machine)",2,90.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Press (Machine)",3,90.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Chest Press (Machine)",4,90.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Strict Military Press (Barbell)",1,0.0,10,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Strict Military Press (Barbell)",2,0.0,8,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Strict Military Press (Barbell)",3,0.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Reverse Fly (Machine)",1,50.0,5,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Reverse Fly (Machine)",2,50.0,5,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Cable Crossover",1,20.0,10,0,0,"",,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Cable Crossover",2,20.0,10,0,0,,,0
2022-01-24 12:40:59,"Afternoon Workout",1h 12m,"Cable Crossover",3,20.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Iso-Lateral Row (Machine)",1,50.0,10,0,0,"","",0
2022-01-25 15:26:45,"Pull",46m,"Iso-Lateral Row (Machine)",2,70.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Iso-Lateral Row (Machine)",3,90.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Iso-Lateral Row (Machine)",4,110.0,5,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Bicep Curl (Machine)",1,30.0,10,0,0,"",,0
2022-01-25 15:26:45,"Pull",46m,"Bicep Curl (Machine)",2,50.0,5,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Bicep Curl (Machine)",3,50.0,5,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Bicep Curl (Machine)",4,50.0,3,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Back Extension (Machine)",1,90.0,10,0,0,"",,0
2022-01-25 15:26:45,"Pull",46m,"Back Extension (Machine)",2,110.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Back Extension (Machine)",3,130.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Back Extension (Machine)",4,130.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Lat Pulldown (Cable)",1,80.0,5,0,0,"",,0
2022-01-25 15:26:45,"Pull",46m,"Lat Pulldown (Cable)",2,90.0,5,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Lat Pulldown (Cable)",3,100.0,5,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Lat Pulldown (Cable)",4,90.0,4,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Elliptical Machine",1,0,0,0.45999999999999996,300,"",,0
2022-01-25 15:26:45,"Pull",46m,"Rowing (Machine)",1,0,0,0.5,300,"",,0
2022-01-25 15:26:45,"Pull",46m,"Crunch (Machine)",1,70.0,10,0,0,"",,0
2022-01-25 15:26:45,"Pull",46m,"Crunch (Machine)",2,70.0,10,0,0,,,0
2022-01-25 15:26:45,"Pull",46m,"Crunch (Machine)",3,70.0,10,0,0,,,0""";

String hevyCSV = """"title","start_time","end_time","description","exercise_title","superset_id","exercise_notes","set_index","set_type","weight_lbs","reps","distance_miles","duration_seconds","rpe"
"Afternoon workout 💪","22 Jul 2023, 07:22","23 Jul 2023, 18:14","","21s Bicep Curl",,"",0,"normal",8,8,,,
"Guy","30 Jun 2023, 15:38","10 Jul 2023, 16:48","","Ab Scissors",,"Hhhh",0,"normal",,8,,,""";