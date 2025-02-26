insert into  nifi_aktarim_hizi (aktarilan_satir_sayisi,started_at,finished_at,sure_dakika,satir_dakika)
select count(*) aktarilan_satir_sayisi
, min(guncelleme) started_at, max(guncelleme) finished_at
, round(TIMESTAMPDIFF(SECOND, min(guncelleme), max(guncelleme))/60,1) sure_dakika
, round(count(*) / (round(TIMESTAMPDIFF(SECOND,min(guncelleme),max(guncelleme))/60,1))) satir_dakika
from Imported.hizdenemenifi
