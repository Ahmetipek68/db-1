create table if not exists film.filmler
(
    FilmID            int auto_increment
        primary key,
    Baslik            varchar(255)                       not null,
    YayimTarihi       date                               null,
    Ozet              text                               null,
    Sure              int                                null,
    OlusturulmaTarihi datetime default CURRENT_TIMESTAMP null,
    GuncellenmeTarihi datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP
);

create table if not exists film.filmdilleri
(
    FilmDilID int auto_increment
        primary key,
    FilmID    int         not null,
    Dil       varchar(50) not null,
    constraint filmdilleri_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID)
);

create index FilmID
    on film.filmdilleri (FilmID);

create table if not exists film.filmulkeleri
(
    FilmUlkeID int auto_increment
        primary key,
    FilmID     int         not null,
    Ulke       varchar(50) not null,
    constraint filmulkeleri_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID)
);

create index FilmID
    on film.filmulkeleri (FilmID);

create table if not exists film.kullanicilar
(
    KullaniciID       int auto_increment
        primary key,
    KullaniciAdi      varchar(50)                        not null,
    Eposta            varchar(100)                       not null,
    Sifre             varchar(255)                       not null,
    OlusturulmaTarihi datetime default CURRENT_TIMESTAMP null,
    GuncellenmeTarihi datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP,
    constraint Eposta
        unique (Eposta)
);

create table if not exists film.bildirimler
(
    BildirimID       int auto_increment
        primary key,
    KullaniciID      int                                not null,
    Mesaj            text                               not null,
    GonderilmeTarihi datetime default CURRENT_TIMESTAMP null,
    Okundu           text                               not null,
    constraint bildirimler_ibfk_1
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID)
);

create index KullaniciID
    on film.bildirimler (KullaniciID);

create table if not exists film.filmpuanlari
(
    PuanID            int auto_increment
        primary key,
    KullaniciID       int                                not null,
    FilmID            int                                not null,
    Puan              int                                null,
    PuanVerilmeTarihi datetime default CURRENT_TIMESTAMP null,
    constraint filmpuanlari_ibfk_1
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID),
    constraint filmpuanlari_ibfk_2
        foreign key (FilmID) references film.filmler (FilmID),
    check (`Puan` between 1 and 10)
);

create index FilmID
    on film.filmpuanlari (FilmID);

create index KullaniciID
    on film.filmpuanlari (KullaniciID);

create table if not exists film.incelemeler
(
    IncelemeID        int auto_increment
        primary key,
    FilmID            int                                not null,
    KullaniciID       int                                not null,
    IncelemeMetni     text                               not null,
    Puan              int                                null,
    OlusturulmaTarihi datetime default CURRENT_TIMESTAMP null,
    constraint incelemeler_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID),
    constraint incelemeler_ibfk_2
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID),
    check (`Puan` between 1 and 10)
);

create table if not exists film.incelemebegenileri
(
    IncelemeBegeniID int auto_increment
        primary key,
    IncelemeID       int                  not null,
    KullaniciID      int                  not null,
    Begendi          tinyint(1) default 1 null,
    constraint incelemebegenileri_ibfk_1
        foreign key (IncelemeID) references film.incelemeler (IncelemeID),
    constraint incelemebegenileri_ibfk_2
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID)
);

create index IncelemeID
    on film.incelemebegenileri (IncelemeID);

create index KullaniciID
    on film.incelemebegenileri (KullaniciID);

create index FilmID
    on film.incelemeler (FilmID);

create index KullaniciID
    on film.incelemeler (KullaniciID);

create table if not exists film.izlemelistesi
(
    IzlemeListesiID int auto_increment
        primary key,
    KullaniciID     int                                not null,
    FilmID          int                                not null,
    EklenmeTarihi   datetime default CURRENT_TIMESTAMP null,
    constraint izlemelistesi_ibfk_1
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID),
    constraint izlemelistesi_ibfk_2
        foreign key (FilmID) references film.filmler (FilmID)
);

create index FilmID
    on film.izlemelistesi (FilmID);

create index KullaniciID
    on film.izlemelistesi (KullaniciID);

create table if not exists film.oduller
(
    OdulID  int auto_increment
        primary key,
    FilmID  int          not null,
    OdulAdi varchar(100) not null,
    Yil     int          not null,
    constraint oduller_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID)
);

create index FilmID
    on film.oduller (FilmID);

create table if not exists film.oyuncular
(
    OyuncuID    int auto_increment
        primary key,
    TamAdi      varchar(100) not null,
    DogumTarihi date         null,
    Uyruk       varchar(50)  null
);

create table if not exists film.filmoyuncular
(
    FilmOyuncuID int auto_increment
        primary key,
    FilmID       int not null,
    OyuncuID     int not null,
    constraint filmoyuncular_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID),
    constraint filmoyuncular_ibfk_2
        foreign key (OyuncuID) references film.oyuncular (OyuncuID)
);

create index FilmID
    on film.filmoyuncular (FilmID);

create index OyuncuID
    on film.filmoyuncular (OyuncuID);

create table if not exists film.roller
(
    RolID  int auto_increment
        primary key,
    RolAdi varchar(50) not null,
    constraint RolAdi
        unique (RolAdi)
);

create table if not exists film.kullanicirolleri
(
    KullaniciRolID int auto_increment
        primary key,
    KullaniciID    int not null,
    RolID          int not null,
    constraint kullanicirolleri_ibfk_1
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID),
    constraint kullanicirolleri_ibfk_2
        foreign key (RolID) references film.roller (RolID)
);

create index KullaniciID
    on film.kullanicirolleri (KullaniciID);

create index RolID
    on film.kullanicirolleri (RolID);

create table if not exists film.turler
(
    TurID  int auto_increment
        primary key,
    TurAdi varchar(50) not null,
    constraint TurAdi
        unique (TurAdi)
);

create table if not exists film.filmturleri
(
    FilmTurID int auto_increment
        primary key,
    FilmID    int not null,
    TurID     int not null,
    constraint filmturleri_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID),
    constraint filmturleri_ibfk_2
        foreign key (TurID) references film.turler (TurID)
);

create index FilmID
    on film.filmturleri (FilmID);

create index TurID
    on film.filmturleri (TurID);

create table if not exists film.yonetenler
(
    YonetmenID  int auto_increment
        primary key,
    TamAdi      varchar(100) not null,
    DogumTarihi date         null,
    Uyruk       varchar(50)  null
);

create table if not exists film.filmyonetenler
(
    FilmYonetmenID int auto_increment
        primary key,
    FilmID         int not null,
    YonetmenID     int not null,
    constraint filmyonetenler_ibfk_1
        foreign key (FilmID) references film.filmler (FilmID),
    constraint filmyonetenler_ibfk_2
        foreign key (YonetmenID) references film.yonetenler (YonetmenID)
);

create index FilmID
    on film.filmyonetenler (FilmID);

create index YonetmenID
    on film.filmyonetenler (YonetmenID);

create table if not exists film.yorumlar
(
    YorumID           int auto_increment
        primary key,
    IncelemeID        int                                not null,
    KullaniciID       int                                not null,
    YorumMetni        text                               not null,
    OlusturulmaTarihi datetime default CURRENT_TIMESTAMP null,
    constraint yorumlar_ibfk_1
        foreign key (IncelemeID) references film.incelemeler (IncelemeID),
    constraint yorumlar_ibfk_2
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID)
);

create table if not exists film.yorumbegenileri
(
    YorumBegeniID int auto_increment
        primary key,
    YorumID       int                  not null,
    KullaniciID   int                  not null,
    Begendi       tinyint(1) default 1 null,
    constraint yorumbegenileri_ibfk_1
        foreign key (YorumID) references film.yorumlar (YorumID),
    constraint yorumbegenileri_ibfk_2
        foreign key (KullaniciID) references film.kullanicilar (KullaniciID)
);

create index KullaniciID
    on film.yorumbegenileri (KullaniciID);

create index YorumID
    on film.yorumbegenileri (YorumID);

create index IncelemeID
    on film.yorumlar (IncelemeID);

create index KullaniciID
    on film.yorumlar (KullaniciID);

