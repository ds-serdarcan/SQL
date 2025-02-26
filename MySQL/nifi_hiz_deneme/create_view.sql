create or replace view vw_nifi_aktarim_hizi as
select count(*) aktarilan_satir_sayisi
, min(guncelleme) started_at, max(guncelleme) finished_at
, round(TIMESTAMPDIFF(SECOND, min(guncelleme), max(guncelleme))/60,1) sure_dakika
, round(count(*) / (round(TIMESTAMPDIFF(SECOND,min(guncelleme),max(guncelleme))/60,1))) satir_dakika
from Imported.hizdenemenifi
