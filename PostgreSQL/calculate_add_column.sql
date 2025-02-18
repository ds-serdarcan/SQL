-------- calculate
SELECT uretimid
,uretimtarihi::date + baslamazamani::time baslamatarihi
,case WHEN bitiszamani >= baslamazamani then uretimtarihi::date + bitiszamani::time
else uretimtarihi::date +1 + bitiszamani::time end bitistarihi
FROM uretim.akis;


-------- add
ALTER TABLE uretim.akis 
ADD COLUMN baslamatarihi TIMESTAMP,
ADD COLUMN bitistarihi TIMESTAMP;


-------- update
UPDATE uretim.akis
SET baslamatarihi = uretimtarihi::DATE + baslamazamani::TIME,
    bitistarihi = CASE 
                    WHEN bitiszamani >= baslamazamani 
                    THEN uretimtarihi::DATE + bitiszamani::TIME
                    ELSE uretimtarihi::DATE + INTERVAL '1 day' + bitiszamani::TIME 
                  END;
