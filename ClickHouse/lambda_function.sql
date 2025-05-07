SELECT max(4351 +
    length(
        arrayFilter(
            x -> (toDayOfWeek(toDate('2025-04-28') + x) <= 5), -- Pazartesi (1) ile Cuma (5) arasını kontrol eder
            range(toUInt64(greatest(0, CAST(date_diff('day', toDate('2025-04-28'), today()) AS Int64))))
        )
    )) AS haftaici_gun_sayisi    
  from ckk_kalite_raporu  
