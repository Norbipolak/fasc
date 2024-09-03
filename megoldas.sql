/*
    3. feladat
    Tóth Antal (1044-es rajtszámmal) 4. körös eredménye kimaradt a nyilvántartásból, pedig
    sikeresen teljesítette a távot. Rögzítse az eredmenyek táblában a futó 15 765 másodperces
    köridejét! 
*/

insert into eredmenyek (futo, kor, ido)
values((select fid from futok where nev = "Toth Antal"),
4,
15765
);

/*
    Listázza ki a női futók nevét és születési évét! A névmező címkéje „futo” legyen! A listát
    rendezze név szerint ábécé rendbe! (4. feladat:) 
*/

select fnev as "futo", szulev from futok
where ffi = 0
order by fnev;

/*
    Listázza ki a 42 éves vagy ennél idősebb futók nevét és korát! A névmező címkéje „futo”,
    a számított mező címkéje „kor” legyen! Az életkorszámítás során a verseny 2016-os
    évszámával számoljon! A listát rendezze az életkor (év és azon belül hónap) szerint
    csökkenő rendbe! 
*/

select fnev as "futo", timestampdiff(year, makedate(szulev, szulho), makedate(2016, 1)) as "kor"
from futok
where timestampdiff(year, makedate(szulev, szulho), makedate(2016, 1)) >= 42
order by szulev, szulho;

/*
    Listázza ki a 10 legjobb köridőt futó férfi nevét és köridejét! A név mező címkéje „futo”
    legyen! (Feltételezheti, hogy nem volt holtverseny a futók között.) (6. feladat:) 
*/

select fnev as "futo", ido
from futok 
inner join eredmenyek 
on futok.fid = eredmenyek.futo
order by ido 
limit 10;

/*
    Listázza ki csapatonként a csapattagok összesített köridejét! A mezők címkéi „csapat” és
    „csapatido” legyen! A listát rendezze úgy, hogy a leggyorsabb csapattal kezdődjön! 
*/

select csapat, sum(ido) as "csapatido" from eredmenyek
inner join futok
on futok.fid = eredmenyek.futo
group by csapat
order by sum(ido);

/*************************************************************************************************/

/*
    Listázza ki az A korcsoportban indulók névsorát ábécé rendben
*/

select nev from versenyzok
where korcsop = "A"
order by nev;

/*
    Listázza ki azon versenyzők rajtszámait, akiknek volt üres gurítása! Ha több üres gurítása
    volt valakinek, akkor is csak egyszer írja ki a rajtszámát!
*/

select distinct versenyzo from eredmenyek 
where ures > 0;

/*
    Listázza ki minden versenyzőre az átlagos tarolási pontértékét! A versenyzők neve mellett
    a számított mező címkéje „atlagpont” legyen! A listát rendezze a számított mező szerint
    csökkenő rendbe!
*/

select nev, AVG(tarolas) as "atlagpont"
from versenyzok
inner join eredmenyek 
on versenyzok.rajtszam = eredmenyek.versenyzo
group by versenyzok.rajtszam
order by AVG(tarolas) DESC;

/*
    Listázza ki a legtöbb versenyzőt adó egyesület nevét!
*/

select egyesuletek.nev, count(egyesuletek.id)
from egyesuletek
inner join versenyzok
on versenyzok.egyid = egyesuletek.id
group by egyesuletek.id
order by count(egyesuletek.id) desc
limit 1;

/*
    Listázza ki a B korcsoport egyéni eredményhirdető táblázatát! A mezők címkéi
    „nev”, „eredmeny”, „tarolas” és „ures” legyen! Az „eredmeny” mezőben a telitalálatok
    összesített pontjának és a tarolások összesített pontjának összegét kell megjeleníteni, míg a
    másik kettőben a névazonos mezők összesítését! A tornán a helyezéseket az alábbiak szerint
    kell eldönteni: összesített eredmények egyenlősége esetén a magasabb tarolási pontszám
    számít, ha pedig ezek is egyenlők, akkor a minél kevesebb üres gurítás! A listát rendezze
    úgy, hogy a legjobb eredményt elérő versenyző nevével kezdődjön!
*/

select nev, sum(teli + tarolas) as "eredmények", tarolas, count(ures = 1) as "üresek"
from eredmenyek
inner join versenyzok
on versenyzok.rajtszam = eredmenyek.versenyzo
where versenyzok.korcsop = "B"
group by versenyzok.rajtszam 
order by sum(teli + tarolas) desc, tarolas desc, count(ures = 1); 
