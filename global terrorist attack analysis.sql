use deneme

--Y�llara G�re Ter�r Sald�r�s� Say�s�

select
	iyear as Yil,
	COUNT(*) AS Saldiri_Sayisi
FROM
	veriler
group by 
	iyear
order by 
	iyear asc

--Attack Distribution by Month

--Aylara G�re Sald�r� Da��l�m�

SELECT
	imonth as Ay,
	COUNT(*) AS Saldiri_Sayisi
FROM
	veriler
where 
	imonth BETWEEN 1 AND 12
GROUP BY 
	imonth
ORDER BY 
	imonth ASC

--Death Toll Trend by Date

--Tarihe G�re �l� Say�s� Trendi

SELECT 
	date,
	SUM(nkill) as Toplam_olu_sayisi
from
	veriler
where	
	date IS NOT NULL
GROUP BY 
	date
ORDER BY 
	date ASC

--Most Dangerous Countries

--En Tehlikeli �lkeler

Select
	country_txt AS Ulke,
	COUNT(*) AS Saldiri_Sayisi
FROM
	veriler
GROUP BY 
	country_txt
order by 
	Saldiri_Sayisi desc

--Number of Attacks by Region

--B�lgelere G�re Sald�r� Say�s�

select
	region_txt as bolge,
	COUNT(*) as Saldiri_Sayisi
FROM
	veriler
group by 
	region_txt
order by 
	Saldiri_Sayisi DESC;

--Attack Rate by Region (%)

--B�lgelere G�re Sald�r� Oran� (%)


SELECT
	region_txt as bolge,
	COUNT(*) AS Saldiri_Sayisi,
	ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM veriler),2) as Saldiri_Orani_Yuzdesi
FROM
	veriler
GROUP BY 
	region_txt
ORDER BY
	Saldiri_Orani_Yuzdesi DESC

--Most Attacked Cities

--En �ok Sald�r� Alan �ehirler

SELECT
	city as sehir,
	COUNT(*) AS Saldiri_sayisi
from
	veriler
WHERE
	city IS NOT NULL AND city <> 'Unknown'
GROUP BY
	city
ORDER BY
	Saldiri_sayisi DESC

--Most Common Types of Attacks

--En Yayg�n Sald�r� T�rleri

SELECT 
	attacktype1_txt as saldiri_turu,
	COUNT(*) as saldiri_sayisi
from
	veriler
where
	attacktype1_txt IS NOT NULL
group by 
	attacktype1_txt
order by 
	saldiri_sayisi DESC


---Most Used Weapon Types
--En �ok Kullan�lan Silah T�rleri


SELECT 
	weaptype1_txt as silah_turu,
	COUNT(*) AS kullanim_sayisi
FROM
	veriler
group by 
	weaptype1_txt
order by 
	kullanim_sayisi desc

--Suicide Attack Rate (%)

--�ntihar Sald�r�s� Oran� (%)

SELECT
	ROUND(100.0 * SUM(CASE WHEN suicide = 1 THEN 1 ELSE 0 END) / COUNT(*),2) AS Intihar_Saldirisi_orani
FROM
	veriler

--Top Deadliest Attacks (by Death Toll)

--En �l�mc�l Sald�r� (�l� Say�s�na G�re)

SELECT 
	eventid,
	iyear,
	imonth,
	iday,
	country_txt as ulke,
	city,
	summary,
	nkill as olu_sayisi
FROM
	veriler
where	
	nkill IS NOT NULL
order by
	nkill DESC

--Total Number of Deaths and Injuries by Year

--Y�llara G�re Toplam �l� ve Yaral� Say�s�

SELECT
	iyear as yil,
	SUM(nkill) as toplam_olu,
	SUM(nwound) as toplam_yarali
from
	veriler
where 
	nkill IS NOT NULL OR nwound IS NOT NULL
GROUP BY
	iyear
ORDER BY 
	iyear

--Successful and Unsuccessful Attacks

--Ba�ar�l� vs Ba�ar�s�z Sald�r�lar

SELECT
	CASE 
		WHEN success = 1 THEN 'Basarili' 
		WHEN success = 0 THEN 'Basarisiz'
		ELSE 'Bilinmiyor'
	END AS durum,
	COUNT(*) AS saldiri_sayisi,
	ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM veriler), 2) AS oran_yuzde	
from 
	veriler
GROUP BY 
	success
order by 
	saldiri_sayisi DESC

--Attack Distribution by Target Typess

--Hedef T�rlerine G�re Sald�r� Da��l�m�

SELECT
	targtype1_txt AS Hedef_Turu,
	COUNT(*) AS saldiri_sayisi,
	ROUND(100.00 * COUNT(*) / (SELECT COUNT(*) FROM veriler),2) as oran
FROM
	veriler
WHERE
	targtype1_txt IS NOT NULL
GROUP BY 
	targtype1_txt
ORDER BY 
	saldiri_sayisi desc

--Groups Carrying Out the Attack

--Sald�r�y� Ger�ekle�tiren Gruplar

SELECT
	gname as Grup_adi,
	COUNT(*) AS saldiri_sayisi
FROM
	veriler
WHERE 
	gname IS NOT NULL AND gname <> 'Unknown'
GROUP BY 
	gname
ORDER BY 
	saldiri_sayisi desc

--Individual or organized?

--Bireysel (individual) mi, �rg�tl� m�?

SELECT
	CASE
		WHEN individual = 1 THEN 'Bireysel'
		WHEN individual = 0 THEN 'Orgutlu'
		ELSE 'bilinmiyor'
	END AS saldiri_tipi,
	COUNT(*) AS saldiri_sayisi,
	ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM veriler),2) as oran
FROM
	veriler
GROUP BY 
	individual
ORDER BY 
	saldiri_sayisi	DESC

--Number of Attacks Passing Ransom

-- Fidye Olay� Ge�en Sald�r� Say�s� 

SELECT 
    COUNT(*) AS fidyeli_saldiri_sayisi
FROM 
    veriler
WHERE 
    ransom = 1;

--Number of Hostage Incidents

--Rehin Alma Olaylar�n�n Say�s�

SELECT 
    COUNT(*) AS rehin_alma_saldiri_sayisi
FROM 
    veriler
WHERE 
    ishostkid = 1;

--Groups carrying out multiple attacks on the same day

--Ayn� g�n i�inde birden fazla sald�r� yapan gruplar

SELECT 
	gname,
	date,
	COUNT(*) AS saldiri_sayisi
FROM 
	veriler
WHERE
	gname IS NOT NULL AND gname <> 'Unknown' AND date IS NOT NULL
GROUP BY 
	gname, date
HAVING
	COUNT(*) > 1
ORDER BY saldiri_sayisi DESC

--Weapon and Target Matches

--Silah ve Hedef E�le�meleri

SELECT 
	weaptype1_txt as silah_turu,
	targtype1_txt as hedef_turu,
	COUNT(*) AS eslesme_sayisi
FROM
	veriler
WHERE
	weaptype1_txt IS NOT NULL AND targtype1_txt IS NOT NULL
GROUP BY
	weaptype1_txt,targtype1_txt
order by 
	eslesme_sayisi

--Calculating a �Terror Index� with All Data
--T�m Verilerle Bir �Ter�r Endeksi� Hesaplamas� 
SELECT 
    eventid,
    iyear,
    country_txt AS ulke,
    city,
    gname AS grup,
    nkill,
    nwound,
    success,
    suicide,
    property,

	COALESCE(nkill, 0)*2 +
    COALESCE(nwound, 0)*1 +
    COALESCE(success, 0)*3 +
    COALESCE(suicide, 0)*2 +
    COALESCE(property, 0)*1 AS teror_endeksis
from 
	veriler
order by teror_endeksis DESC