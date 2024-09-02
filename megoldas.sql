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
order by szulev, szulho 

/*
    Listázza ki a 10 legjobb köridőt futó férfi nevét és köridejét! A név mező címkéje „futo”
    legyen! (Feltételezheti, hogy nem volt holtverseny a futók között.) (6. feladat:) 
*/

select fnev as "futo", ido
from futok 
inner join eredmenyek 
on futok.fid = eredmenyek.futo
order by ido 
limit 10

/*
    Listázza ki csapatonként a csapattagok összesített köridejét! A mezők címkéi „csapat” és
    „csapatido” legyen! A listát rendezze úgy, hogy a leggyorsabb csapattal kezdődjön! 
*/

select csapat, sum(ido) as "csapatido" from eredmenyek
inner join futok
on futok.fid = eredmenyek.futo
group by csapat
order by sum(ido)

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
where ures > 0
