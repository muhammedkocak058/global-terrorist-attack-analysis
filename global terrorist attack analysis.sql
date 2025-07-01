use deneme

--Yýllara Göre Terör Saldýrýsý Sayýsý

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

--Aylara Göre Saldýrý Daðýlýmý

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

--Tarihe Göre Ölü Sayýsý Trendi

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

--En Tehlikeli Ülkeler

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

--Bölgelere Göre Saldýrý Sayýsý

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

--Bölgelere Göre Saldýrý Oraný (%)


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

--En Çok Saldýrý Alan Þehirler

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

--En Yaygýn Saldýrý Türleri

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
--En Çok Kullanýlan Silah Türleri


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

--Ýntihar Saldýrýsý Oraný (%)

SELECT
	ROUND(100.0 * SUM(CASE WHEN suicide = 1 THEN 1 ELSE 0 END) / COUNT(*),2) AS Intihar_Saldirisi_orani
FROM
	veriler

--Top Deadliest Attacks (by Death Toll)

--En Ölümcül Saldýrý (Ölü Sayýsýna Göre)

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

--Yýllara Göre Toplam Ölü ve Yaralý Sayýsý

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

--Baþarýlý vs Baþarýsýz Saldýrýlar

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

--Hedef Türlerine Göre Saldýrý Daðýlýmý

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

--Saldýrýyý Gerçekleþtiren Gruplar

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

--Bireysel (individual) mi, örgütlü mü?

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

-- Fidye Olayý Geçen Saldýrý Sayýsý 

SELECT 
    COUNT(*) AS fidyeli_saldiri_sayisi
FROM 
    veriler
WHERE 
    ransom = 1;

--Number of Hostage Incidents

--Rehin Alma Olaylarýnýn Sayýsý

SELECT 
    COUNT(*) AS rehin_alma_saldiri_sayisi
FROM 
    veriler
WHERE 
    ishostkid = 1;

--Groups carrying out multiple attacks on the same day

--Ayný gün içinde birden fazla saldýrý yapan gruplar

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

--Silah ve Hedef Eþleþmeleri

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

--Calculating a “Terror Index” with All Data
--Tüm Verilerle Bir “Terör Endeksi” Hesaplamasý 
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