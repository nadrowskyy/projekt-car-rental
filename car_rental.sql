-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 28 Sty 2021, 17:15
-- Wersja serwera: 10.4.14-MariaDB
-- Wersja PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `car_rental`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `accidents`
--

CREATE TABLE `accidents` (
  `UserID` int(4) DEFAULT NULL,
  `Date` date DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `WhenReported` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Zrzut danych tabeli `accidents`
--

INSERT INTO `accidents` (`UserID`, `Date`, `Description`, `WhenReported`) VALUES
(4, '2021-01-26', 'Silnik nie dziala', '2021-01-21');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `additional_services`
--

CREATE TABLE `additional_services` (
  `OrderID` int(11) NOT NULL,
  `IfAbroad` tinyint(1) DEFAULT NULL,
  `IfChildSeat` int(11) DEFAULT NULL,
  `IfUsedByNoreUsers` tinyint(1) DEFAULT NULL,
  `InsuranceID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `additional_services`
--

INSERT INTO `additional_services` (`OrderID`, `IfAbroad`, `IfChildSeat`, `IfUsedByNoreUsers`, `InsuranceID`) VALUES
(1, 1, 1, 1, 1),
(2, 1, 0, 1, 2),
(3, 1, 0, 1, 3),
(4, 1, 1, 0, 2),
(5, 1, 1, 1, 1),
(6, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_polish_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_polish_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_polish_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_polish_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_polish_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_polish_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cars`
--

CREATE TABLE `cars` (
  `CarID` int(11) NOT NULL,
  `Model` varchar(10) COLLATE utf8_polish_ci NOT NULL,
  `Mark` varchar(10) COLLATE utf8_polish_ci NOT NULL,
  `SegmentID` int(11) NOT NULL,
  `IfRented` tinyint(1) NOT NULL DEFAULT 0,
  `BodyType` enum('COMBI','HATCHBACK','SEDAN','COUPE','CABRIO','LIMUZYNA') COLLATE utf8_polish_ci NOT NULL,
  `TransmissionType` enum('MANUAL','AUTOMAT','SEMIMANUAL') COLLATE utf8_polish_ci NOT NULL,
  `FuelType` varchar(20) COLLATE utf8_polish_ci NOT NULL,
  `SeatsNumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `cars`
--

INSERT INTO `cars` (`CarID`, `Model`, `Mark`, `SegmentID`, `IfRented`, `BodyType`, `TransmissionType`, `FuelType`, `SeatsNumber`) VALUES
(1, 'Citigo', 'Skoda', 1, 1, 'HATCHBACK', 'MANUAL', 'BENZYNA', 4),
(2, 'Aygo', 'Toyota', 1, 0, 'HATCHBACK', 'AUTOMAT', 'BENZYNA', 4),
(3, 'Ford', 'Fiesta', 2, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(4, 'Megane', 'Renault', 3, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(5, 'Supra', 'Toyota', 8, 0, 'COUPE', 'AUTOMAT', 'BENZYNA', 2),
(7, 'Polo', 'Volkswagen', 2, 1, 'HATCHBACK', 'AUTOMAT', 'DIESEL', 5),
(8, '6', 'Mazda', 5, 0, 'SEDAN', 'AUTOMAT', 'BENZYNA', 5),
(9, 'Insignia', 'Opel', 5, 0, 'HATCHBACK', 'MANUAL', 'DIESEL', 5),
(10, 'Space Star', 'Mitsubishi', 1, 1, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(11, 'Octavia', 'Skoda', 4, 0, 'COMBI', 'MANUAL', 'BENZYNA', 5),
(12, 'Mustang', 'Ford', 8, 0, 'CABRIO', 'SEMIMANUAL', 'BENZYNA', 4),
(13, 'Focus', 'Ford', 3, 0, 'HATCHBACK', 'AUTOMAT', 'DIESEL', 5),
(14, 'Seria 5', 'BMW', 6, 1, 'LIMUZYNA', 'SEMIMANUAL', 'BENZYNA', 5),
(15, 'A8', 'Audi', 7, 0, 'LIMUZYNA', 'AUTOMAT', 'BENZYNA', 5),
(16, 'Aygo', 'Toyota', 1, 0, 'HATCHBACK', 'AUTOMAT', 'BENZYNA', 4),
(17, 'Avensis', 'Toyora', 5, 0, 'SEDAN', 'MANUAL', 'BENZYNA', 5),
(18, 'Astra', 'Opel', 3, 1, 'HATCHBACK', 'MANUAL', 'DIESEL', 5),
(19, 'R8', 'Audi', 8, 0, 'COUPE', 'AUTOMAT', 'BENZYNA', 2),
(20, 'Citigo', 'Skoda', 1, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 4),
(21, 'S90', 'Volvo', 6, 0, 'LIMUZYNA', 'AUTOMAT', 'DIESEL', 5),
(22, 'i30', 'Hyundai', 3, 0, 'COMBI', 'MANUAL', 'DIESEL', 5),
(23, 'Aygo', 'Toyota', 1, 1, 'HATCHBACK', 'AUTOMAT', 'BENZYNA', 4),
(24, 'Arteon', 'Volkswagen', 6, 1, 'LIMUZYNA', 'SEMIMANUAL', 'BENZYNA', 5),
(25, 'Space Star', 'Mitsubishi', 1, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(26, 'Insignia', 'Opel', 5, 0, 'HATCHBACK', 'AUTOMAT', 'BENZYNA', 5),
(27, 'Fiesta', 'Ford', 2, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(28, 'Octavia', 'Skoda', 4, 1, 'COMBI', 'MANUAL', 'BENZYNA', 5),
(29, 'Mustang', 'Ford', 8, 0, 'COUPE', 'MANUAL', 'BENZYNA', 4),
(30, 'Megane', 'Renault', 3, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(31, 'Fabia', 'Skoda', 2, 0, 'COMBI', 'MANUAL', 'BENZYNA', 5),
(32, 'Fiesta', 'Ford', 2, 0, 'HATCHBACK', 'MANUAL', 'DIESEL', 5),
(33, 'Yaris', 'Toyota', 2, 0, 'HATCHBACK', 'MANUAL', 'BENZYNA', 5),
(34, 'S90', 'Volvo', 6, 1, 'LIMUZYNA', 'AUTOMAT', 'DIESEL', 5),
(35, 'Focus', 'Ford', 3, 1, 'SEDAN', 'MANUAL', 'BENZYNA', 5),
(36, 'A8', 'Audi', 7, 0, 'LIMUZYNA', 'AUTOMAT', 'BENZYNA', 5),
(37, 'Seria 3', 'BMW', 5, 0, 'SEDAN', 'SEMIMANUAL', 'BENZYNA', 5),
(38, 'Corvette', 'Chevrolet', 8, 1, 'CABRIO', 'AUTOMAT', 'BENZYNA', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `cars_detail`
--

CREATE TABLE `cars_detail` (
  `CarID` int(11) DEFAULT NULL,
  `mileage_city` float DEFAULT NULL,
  `mileage_road` float DEFAULT NULL,
  `boot_capacity` int(5) DEFAULT NULL,
  `doors_number` int(11) DEFAULT NULL,
  `conditioning_type` varchar(128) COLLATE utf8_polish_ci DEFAULT NULL,
  `engine_capacity` int(4) DEFAULT NULL,
  `engine_power` int(4) DEFAULT NULL,
  `drive` enum('FWD','RWD','AWD') COLLATE utf8_polish_ci DEFAULT NULL,
  `air_pillow_number` int(11) DEFAULT NULL,
  `electric_windows` int(1) DEFAULT NULL,
  `electric_mirrors` tinyint(1) DEFAULT NULL,
  `heated_mirrors` tinyint(1) DEFAULT NULL,
  `VIN_number` varchar(17) COLLATE utf8_polish_ci DEFAULT NULL,
  `image` varchar(128) COLLATE utf8_polish_ci DEFAULT NULL,
  `url_to_autocentrum` varchar(256) COLLATE utf8_polish_ci DEFAULT NULL,
  `description` text COLLATE utf8_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `cars_detail`
--

INSERT INTO `cars_detail` (`CarID`, `mileage_city`, `mileage_road`, `boot_capacity`, `doors_number`, `conditioning_type`, `engine_capacity`, `engine_power`, `drive`, `air_pillow_number`, `electric_windows`, `electric_mirrors`, `heated_mirrors`, `VIN_number`, `image`, `url_to_autocentrum`, `description`) VALUES
(1, 5.8, 3.9, 251, 3, 'MANUALNA', 999, 75, 'FWD', 6, 2, 1, 0, 'TMBZZZAAZGD618792', 'images/cars/skoda_citigo.png', 'https://www.autocentrum.pl/skoda/citigo/hatchback-3d-facelifting/silnik-benzynowy-1.0-mpi-75km-2017-2019/', 'Produkowana od roku 2011 Skoda Citigo to mały samochód należący do segmentu A. Jest najmniejszym autem w katalogu czeskiego producenta, najmniejszym także, jaki do tej pory w historii wyprodukowała Skoda - jest nawiązaniem do prototypu z lat 30. XX w. o nazwie Skoda Sgitta (nigdy nie wdrożony do produkcji, mały samochód dla ludu). Sama nazwa Citigo wskazuje przeznaczenie modelu - ma być miejskim autem, które zapełni lukę w tym segmencie w ofercie czeskiej marki. Skoda Citigo zbudowana została na platformie podłogowej VW Group MQB Platform, w ramach projektu NSF (New Small Family) uruchomionego przez Volkswagena, a jego modelami bliźniaczymi są VW up! oraz Seat Mii.'),
(2, 5.5, 3.8, 168, 3, 'AUTOMATYCZNA', 998, 72, 'FWD', 8, 2, 1, 1, 'JTDKGNEC20N554521', 'images/cars/toyota_aygo.png', 'https://www.autocentrum.pl/dane-techniczne/toyota/aygo/ii/hatchback-3d-facelifting/silnik-benzynowy-1.0-vvt-i-72km-od-2018/', 'Dynamiczne i zwrotne AYGO idealnie sprawdza się na miejskich ulicach i oferuje zaskakującą pakowność i komfort jazdy. Poznaj wszystkie wyjątkowe wersje wyposażenia i stwórz auto dopasowane do własnej osobowości. Zainspiruj się odważnym designem AYGO w nowych wersjach kolorystycznych Selection x-cite oraz JBL Edition z dachem w kontrastującym odcieniu. Wsiadaj i ruszaj przed siebie!'),
(3, 5.4, 3.6, 292, 5, 'AUTOMATYCZNA', 999, 100, 'FWD', 6, 2, 2, 2, 'WF0FXXGAHFLR66273', 'images/cars/ford_fiesta.png', 'https://www.autocentrum.pl/ford/fiesta/viii/hatchback-5d/silnik-benzynowy-1.0-ecoboost-100km-2017-2020/', 'Usiądź za kierownicą Forda Fiesta i poznaj inteligentne technologie ułatwiające jazdę - np. wspomaganie parkowania, aktywny tempomat, rozpoznawanie znaków drogowych czy system wspomagający utrzymanie pojazdu na pasie ruchu. Przygotuj się na technologie, z którymi każdy kilometr podróży staje się czystą przyjemnością.'),
(4, 6.6, 4.9, 402, 5, 'MANUALNA', 1332, 140, 'FWD', 8, 4, 1, 1, 'VF1RFB00365519359', 'images/cars/renault_megane.png', 'https://www.autocentrum.pl/renault/megane/iv/hatchback-5d-facelifting/silnik-benzynowy-1.3-tce-140km-od-2020/', 'Debiutująca na rynku w roku 2016, obecnie produkowana, czwarta generacja modelu jest następną rewolucją stylistyczną. Megane IV został zaprojektowany według nowej koncepcji designu francuskiej marki, której skorzystano wcześniej w modelach Captur, Clio IV generacji oraz Espace V generacji. Renault Megane czwartej generacji powstało na platformie podłogowej CMF-CD, będącej owocem współpracy Renault i Nissana, na której zbudowane są także Nissan Quashqai oraz Renault Talisman. Samochód oferowany jest w wariantach: hatchback, kombi oraz sedan (powracający do oferty, jako że w przypadku trzeciej generacji Megane, był on autonomicznym modelem o nazwie Fluence). Wersję usportowioną auta nazwano Renault Megane GT.'),
(5, 17.2, 7.3, 290, 2, 'AUTOMATYCZNA', 2998, 340, 'RWD', 7, 2, 1, 1, 'YBCDB41000W024502', 'images/cars/toyota_supra.png', 'https://www.autocentrum.pl/toyota/supra/v/silnik-benzynowy-3.0-gr-340km-od-2019/', 'Toyota GR Supra to auto o bogatej tradycji, które gwarantuje najczystszą radość z jazdy. Ekscytujące połączenie mocy, harmonii i zwinności podbija serca fanów motoryzacji, dając im niespotykaną przyjemność prowadzenia w sportowym stylu.'),
(7, 4.5, 3.2, 351, 5, 'AUTOMATYCZNA', 1598, 95, 'FWD', 6, 4, 4, 1, 'WVWZZZAWZLU113340', 'images/cars/volkswagen_polo.png', 'https://www.autocentrum.pl/volkswagen/polo/vi/hatchback-5d/silnik-diesla-1.6-tdi-95km-od-2017/', 'Debiutująca na rynku w roku 2017, obecnie produkowana, szósta generacja Volkswagena Polo pod względem stylistycznym niewiele się zmieniła, czerpiąc inspirację z rozwiązań zastosowanych w najnowszych modelach Golf i Passat. Samochód został zaprojektowany przez Klausa Bishoffa. Volkswagen Polo VI zbudowany został na nowej platformie podłogowej Volkswagen Group MQB A0 (dedykowanej wszystkim samochodom miejskim w grupie Volkswagen), podobnie jak m.in. Seat Ibiza piątej generacji. Inaczej niż poprzednicy, Polo szóstej generacji dostępny jest na Starym Kontynencie wyłącznie w odmianie pięciodrzwiowego hatchbacka (wersja sedan - Virtus - dostępna jest wyłącznie na południowoamerykańskim rynku).'),
(8, 8.5, 5, 480, 4, 'AUTOMATYCZNA', 2488, 194, 'FWD', 8, 4, 1, 1, 'JMZGL62M801718771', 'images/cars/mazda_6.png', 'https://www.autocentrum.pl/mazda/6/iii/sedan-facelifting-2018/silnik-benzynowy-2.5-skyactiv-g-194km-od-2018/', 'Dzięki znakomitej charakterystyce prowadzenia oraz dojrzałej i atrakcyjnej stylistyce, Mazda6 w wersji Sedan przykuwa wzrok zarówno w ruchu miejskim jak i na trasie. Nowa Mazda6 Sedan na nowo definiuje pojęcia jakości i stylu, oferując niezwykle dopracowaną konstrukcję, najnowsze rozwiązania technologiczne oraz odświeżoną stylistykę zgodną z zasadami filozofii KODO - Dusza Ruchu. Odpręż się i rozkoszuj urzekającą stylizacją stworzonej z myślą o człowieku kabiny, której projekt obejmuje przemyślane połączenie takich materiałów jak skóra naturalna, drewno i zamsz oraz zapewnia najwyższy komfort jazdy, m.in. dzięki systemowy wentylacji przednich foteli.'),
(9, 5.5, 4.6, 490, 5, 'AUTOMATYCZNA', 1995, 174, 'FWD', 8, 4, 4, 1, 'W0VZT6GB4L1025769', 'images/cars/open_insignia.png', 'https://www.autocentrum.pl/opel/insignia/ii/grand-sport-facelifting/silnik-diesla-2.0-diesel-174km-od-2020/', 'Nowa Insignia o dystyngowanej sylwetce i smukłych liniach w pełni zasługuje na swoją nazwę. Reflektory LED o wąskim profilu, i z charakterystycznym dla marki świetlnym motywem skrzydła, oraz chromowane akcenty ozdobne prezentują się niezwykle szykownie. Z każdym odblokowaniem zamków Twoja Insignia wita Cię sekwencją błyśnięć reflektorów. '),
(10, 6.1, 5.8, 235, 5, 'MANUALNA', 999, 71, 'FWD', 6, 4, 1, 0, 'MMCXTA03ALH010554', 'images/cars/mitsubishi_spacestar.png', 'https://www.autocentrum.pl/dane-techniczne/mitsubishi/space-star/hatchback-5d-facelifting-ii/silnik-benzynowy-1.0-71km-od-2020/', 'Nowy Space Star to auto miejskie, które wyróżnia się elektryzującym designem i niezawodnymi rozwiązaniami. Ilość konfiguracji i dostępnych kolorów sprawi, że każdy znajdzie rozwiązanie idealne dla siebie. Skrzynia automatyczna dostępna jest do wielu wersji wyposażenia sprawiając, że jest to unikatowa i najlepsza oferta na rynku. W wersji INSPORT, wyposażonej w dodatkowy pakiet stylizacyjny, Mitsubishi Space Star prezentuje się dynamicznie i agresywnie. W wersji INSTYLE znajdują się zaś najnowocześniejsze systemy, w tym multimedialny SDA, bezpieczeństwa: FCM, AHB, LDW, oraz światła główne w technologii LED. Wersja bazowa INFORM ma już wszystko to, by dać Ci radość z jazdy np.: klimatyzację, radio, ale też automatyczne wycieraczki i światła mijania z czujnikiem zmierzchu. Space Star to auto, które zaskoczy Ciebie niskim spalaniem, zwrotnością, komfortem i przestrzenią w środku.'),
(11, 8.3, 5.3, 640, 5, 'AUTOMATYCZNA', 1498, 150, 'FWD', 8, 4, 4, 1, 'TMBAJ7NX3MY027376', 'images/cars/skoda_octavia.png', 'https://www.autocentrum.pl/skoda/octavia/iv/kombi/silnik-benzynowy-1.5-tsi-150km-od-2020/', 'Całkowicie nowa, jeszcze bardziej przestronna Octavia Combi pomieści całą rodzinę. Auto posiada mnóstwo miejsca dla wszytskich pasażerów, a także przepastny bagażnik. Nowa stylistyka pozwala cieszyć się najwyższą jakością elegancji.'),
(12, 16.6, 8.8, 408, 2, 'Automatyczna', 5038, 460, 'RWD', 8, 2, 2, 1, '1FA6P8K0XL5580842', 'images/cars/ford_mustang_460.png', 'https://www.autocentrum.pl/ford/mustang/vi/fastback-facelifting/silnik-benzynowy-5.0-ti-vct-460km-od-2018/', 'Wprowadzona na rynek w roku 2014 najnowsza i obecnie produkowana, szósta generacja modelu, jest największym w dotychczasowej historii Mustanga przełomem – jest pierwszym Mustangiem oferowanym oficjalnie na Starym Kontynencie. Stało się to za sprawą fordowskiej strategii „One Ford”. Już w roku 2009 ruszyły prace na tym modelem, który korzysta ze stylistycznych rozwiązań prototypu Evos z roku 2011, w przeciwieństwie natomiast do swoich poprzedników, jest oparty konstrukcyjnie na nowych rozwiązaniach, które zostały opracowane właśnie dla nowego Mustanga.'),
(13, 5.1, 4.2, 375, 5, 'AUTOMATYCZNA', 1996, 150, 'FWD', 8, 2, 1, 1, 'WF0NXXGCHNKU44268', 'images/cars/ford_focus_hatchback.png', 'https://www.autocentrum.pl/ford/focus/iv/hatchback/silnik-diesla-2.0-ecoblue-150km-od-2018/', 'Przedstawiamy wyjątkowego, zupełnie Forda Focus, zaprojektowanego tak, aby każda podróż była łatwiejsza, bezpieczniejsza i przyjemniejsza. Wyposażono go w szereg zaawansowanych rozwiązań technicznych zaprojektowanych specjalnie z myślą o użytkownikach. Począwszy od wielokrotnie nagradzanych systemów łączności, takich jak Ford SYNC 3, po zaawansowane systemy wspomagające kierowcę, które z Tobą współpracują - wszystkie one sprawiają, że podróżowanie staje się łatwiejsze.'),
(14, 6.8, 4, 530, 4, 'AUTOMATYCZNA', 1998, 252, 'RWD', 12, 4, 4, 4, 'WBA11BJ050CF33679', 'images/cars/bmw_seria5.png', 'https://www.autocentrum.pl/bmw/seria-5/g30-g31/limuzyna-facelifting/silnik-benzynowy-2.0-530i-252km-od-2020/', 'BMW serii 5 Limuzyna to synonim sportowej limuzyny biznesowej. Już na pierwszy rzut oka pokazuje sportowy styl, który wyraża się przede wszystkim w dynamicznej sylwetce i minimalistycznej stylistyce. Wyraziste powierzchnie i precyzyjne kontury nadają eleganckiej karoserii nowoczesny, techniczny wygląd. Szlachetne i funkcjonalne wnętrze uzupełnia innowacyjny charakter samochodu o innowacyjne technologie i sportowe wyposażenie.'),
(15, 14, 12, 505, 4, 'AUTOMATYCZNA', 3996, 460, 'AWD', 12, 4, 4, 1, 'WAUZZZF82KN016413', 'images/cars/audi_a8.png', 'https://www.autocentrum.pl/audi/a8/d5/sedan/silnik-benzynowy-4.0-60-tfsi-460km-od-2020/', 'Stylistyka wyznaczająca początek nowej ery dla marki Audi. 41 inteligentnych systemów Audi AI wspierających kierowcę podczas jazdy. Nowy poziom intuicyjnej obsługi za pomocą dotykowych ekranów i głosu. Perfekcyjnie zaprojektowane i wykonane wnętrze, gwarantujące najwyższy komfort podróżowania. Audi A8 na nowo definiuje limuzynę klasy Premium i wyznacza kierunek rozwoju współczesnej motoryzacji.'),
(16, 5.5, 3.8, 168, 3, 'AUTOMATYCZNA', 998, 72, 'FWD', 8, 2, 1, 1, 'JTDKGNEC60N556840', 'images/cars/toyota_aygo.png', 'https://www.autocentrum.pl/dane-techniczne/toyota/aygo/ii/hatchback-3d-facelifting/silnik-benzynowy-1.0-vvt-i-72km-od-2018/', 'Dynamiczne i zwrotne AYGO idealnie sprawdza się na miejskich ulicach i oferuje zaskakującą pakowność i komfort jazdy. Poznaj wszystkie wyjątkowe wersje wyposażenia i stwórz auto dopasowane do własnej osobowości. Zainspiruj się odważnym designem AYGO w nowych wersjach kolorystycznych Selection x-cite oraz JBL Edition z dachem w kontrastującym odcieniu. Wsiadaj i ruszaj przed siebie!'),
(17, 8.1, 4.9, 509, 4, 'AUTOMATYCZNA', 1798, 147, 'FWD', 8, 4, 4, 1, 'SB1EG76L70E162260', 'images/cars/toyota_avensis.png', 'https://www.autocentrum.pl/toyota/avensis/iii/sedan-facelifting-2015/silnik-benzynowy-1.8-valvematic-147km-2015-2018/', 'Nowy design i legendarna niezawodność konstrukcji z kraju kwitnącej wiśni. Przestronna kabina, która z łatwością przetransportuje 5 osób, oraz równie pojemny bagażnik, dzięki któremu każde na każde wakacje, możliwe będzie zabranie wszystkich potrzebnych przedmiotów.'),
(18, 5.2, 3.7, 370, 5, 'MANUALNA', 1496, 122, 'FWD', 8, 2, 1, 1, 'W0VBE6EW6LG017557', 'images/cars/opel_astra.png', 'https://www.autocentrum.pl/opel/astra/k/hatchback-facelifting/silnik-diesla-1.5-diesel-122km-od-2019/', 'Piąta generacja Opla Astry swoją światową premierę miała w 2015 r. podczas wystawy samochodowej IAA we Frankfurcie. Jedną ze stylistycznych inspiracji dla projektantów najnowszej Astry stał się prototyp z roku 2013 - Monza Concept. Produkcyjną wersję Opla Astry K zbudowano na nowej platformie podłogowej GM Delta D2XX, podobnie jak m.in. Chevrolety - Cruze oraz Volt. Opel Astra piątej generacji jest nieco mniejszy i lżejszy od poprzedniczki (o ok. 120 kilogramów). Model dostępny jest także w wariancie kombi, tak jak w przypadku Astry J nosi oznaczenie Sports Tourer. Na innych rynkach funkcjonuje pod nazwami Vauxhall i Holden Astra oraz Buick Verano Hatch. W 2016 r. Opel Astra K został zwycięzcą plebiscytu na Europejski Samochód Roku. Tak jak poprzednie generacje modelu, tak i Opel Astra K wytwarzany jest m.in. w zakładach Opla w Gliwicach.'),
(19, 20, 9, 112, 2, 'AUTOMATYCZNA', 5204, 620, 'AWD', 8, 2, 1, 1, 'WUAZZZFX5M7900253', 'images/cars/audi_r8.png', 'https://www.autocentrum.pl/audi/r8/ii/coupe-facelifting/silnik-benzynowy-5.2-fsi-620km-od-2019/', 'Niezależnie od tego, z jakiej perspektywy spojrzy się na Audi R8, jednego można być pewnym: to najwyższej klasy samochód sportowy łączący w sobie estetykę z jeszcze większą niż dotychczas mocą. Audi R8 udowadnia, że potężna moc i elegancja mogą stworzyć doskonały mariaż. Po kompleksowym odświeżeniu Audi R8 przekonuje do siebie oszałamiającymi osiągami oraz dopracowanym designem, a jeszcze bardziej drapieżny wygląd łączy je ze sportami motorowymi mocniej niż jakiekolwiek inne Audi.'),
(20, 5.8, 3.9, 251, 5, 'MANUALNA', 999, 75, 'FWD', 6, 2, 1, 0, 'TMBZZZAAZKD632721', 'images/cars/skoda_citigo.png', 'https://www.autocentrum.pl/skoda/citigo/hatchback-3d-facelifting/silnik-benzynowy-1.0-mpi-75km-2017-2019/', 'Produkowana od roku 2011 Skoda Citigo to mały samochód należący do segmentu A. Jest najmniejszym autem w katalogu czeskiego producenta, najmniejszym także, jaki do tej pory w historii wyprodukowała Skoda - jest nawiązaniem do prototypu z lat 30. XX w. o nazwie Skoda Sgitta (nigdy nie wdrożony do produkcji, mały samochód dla ludu). Sama nazwa Citigo wskazuje przeznaczenie modelu - ma być miejskim autem, które zapełni lukę w tym segmencie w ofercie czeskiej marki. Skoda Citigo zbudowana została na platformie podłogowej VW Group MQB Platform, w ramach projektu NSF (New Small Family) uruchomionego przez Volkswagena, a jego modelami bliźniaczymi są VW up! oraz Seat Mii.'),
(21, 8.2, 6.5, 500, 4, 'AUTOMATYCZNA', 1969, 235, 'AWD', 12, 4, 4, 1, 'LVYPSA3VCLP085686', 'images/cars/volvo_s90.png', 'https://www.autocentrum.pl/volvo/s90/ii/sedan-facelifting/silnik-diesla-2.0-d5-235km-2020/', 'Żyj po swojemu Kontroluj każdy kilometr drogi dzięki intuicyjnym rozwiązaniom zwiększającym komfort jazdy. Wyróżnij się odświeżonym wyglądem nadwozia, nowymi chromowanymi detalami i grillem. Zarówno na przednich, jak i tylnych fotelach masz mnóstwo miejsca na nogi, a wyjątkowo miękka i delikatna skóra nappa jeszcze bardziej podnosi poziom luksusu. Środkowy podłokietnik składa się w dół, aby zapewnić Ci jeszcze lepsze warunki odpoczynku w długiej trasie.'),
(22, 5.1, 3.4, 602, 5, 'AUTOMATYCZNA', 1598, 115, 'FWD', 6, 4, 1, 1, 'TMAH351CAMJ140497', 'images/cars/hyundai_i30_combi.png', 'https://www.autocentrum.pl/hyundai/i30/iii/wagon-facelifting/silnik-diesla-1.6-crdi-115km-od-2020/', 'Precyzyjnie ukształtowana sylwetka nadwozia i dopracowane detale tworzą samochód o niezwykłej elegancji i wyrafinowaniu. Drugi raz z rzędu Hyundai znalazł się na pierwszym miejscu Raportu Jakości tygodnika Auto Świat (nr 5, 28 stycznia 2019), wyprzedzając wszystkie oceniane marki samochodowe, w tym marki premium. Ponowne pierwsze miejsce Hyundaia w rankingu jest najlepszym dowodem na wysoką jakość samochodów marki. Więcej informacji o Raporcie Jakości Auto Świat.'),
(23, 5.5, 3.8, 168, 3, 'AUTOMATYCZNA', 998, 72, 'FWD', 8, 2, 1, 1, 'JTDKGNEC30N557802', 'images/cars/toyota_aygo.png', 'https://www.autocentrum.pl/dane-techniczne/toyota/aygo/ii/hatchback-3d-facelifting/silnik-benzynowy-1.0-vvt-i-72km-od-2018/', 'Dynamiczne i zwrotne AYGO idealnie sprawdza się na miejskich ulicach i oferuje zaskakującą pakowność i komfort jazdy. Poznaj wszystkie wyjątkowe wersje wyposażenia i stwórz auto dopasowane do własnej osobowości. Zainspiruj się odważnym designem AYGO w nowych wersjach kolorystycznych Selection x-cite oraz JBL Edition z dachem w kontrastującym odcieniu. Wsiadaj i ruszaj przed siebie!'),
(24, 6, 4.6, 563, 4, 'AUTOMATYCZNA', 1984, 190, 'AWD', 12, 4, 4, 1, 'WVWZZZ3HZME004040', 'images/cars/volkswagen-arteon.png', 'https://www.autocentrum.pl/volkswagen/arteon/fastback-facelifting/silnik-benzynowy-2.0-tsi-190km-od-2020/', 'Nie sposób nie rozpoznać nowego Arteona, który już od pierwszego spojrzenia zachwyca designem i smukłą linią nadwozia. Wejdź do środka, a stylowe wnętrze i intuicyjne sterowanie nie pozwoli Ci wysiąść. Ekstrawagancki, a jednocześnie bez żadnej skazy - ten sportowy sedan zniewala pewnością siebie.'),
(25, 6.1, 5.8, 235, 5, 'MANUALNA', 999, 71, 'FWD', 6, 4, 1, 1, 'MMCXNA03ALH021130', 'images/cars/mitsubishi_spacestar.png', 'https://www.autocentrum.pl/dane-techniczne/mitsubishi/space-star/hatchback-5d-facelifting-ii/silnik-benzynowy-1.0-71km-od-2020/', 'Nowy Space Star to auto miejskie, które wyróżnia się elektryzującym designem i niezawodnymi rozwiązaniami. Ilość konfiguracji i dostępnych kolorów sprawi, że każdy znajdzie rozwiązanie idealne dla siebie. Skrzynia automatyczna dostępna jest do wielu wersji wyposażenia sprawiając, że jest to unikatowa i najlepsza oferta na rynku. W wersji INSPORT, wyposażonej w dodatkowy pakiet stylizacyjny, Mitsubishi Space Star prezentuje się dynamicznie i agresywnie. W wersji INSTYLE znajdują się zaś najnowocześniejsze systemy, w tym multimedialny SDA, bezpieczeństwa: FCM, AHB, LDW, oraz światła główne w technologii LED. Wersja bazowa INFORM ma już wszystko to, by dać Ci radość z jazdy np.: klimatyzację, radio, ale też automatyczne wycieraczki i światła mijania z czujnikiem zmierzchu. Space Star to auto, które zaskoczy Ciebie niskim spalaniem, zwrotnością, komfortem i przestrzenią w środku.'),
(26, 8.3, 7.4, 490, 5, 'AUTOMATYCZNA', 1998, 170, 'FWD', 8, 4, 4, 1, 'W0VZT6GR8M1002865', 'images/cars/open_insignia.png', 'https://www.autocentrum.pl/opel/insignia/ii/grand-sport-facelifting/silnik-benzynowy-2.0-turbo-170km-od-2020/', 'Nowa Insignia o dystyngowanej sylwetce i smukłych liniach w pełni zasługuje na swoją nazwę. Reflektory LED o wąskim profilu, i z charakterystycznym dla marki świetlnym motywem skrzydła, oraz chromowane akcenty ozdobne prezentują się niezwykle szykownie. Z każdym odblokowaniem zamków Twoja Insignia wita Cię sekwencją błyśnięć reflektorów. '),
(27, 5.4, 3.6, 292, 5, 'AUTOMATYCZNA', 999, 100, 'FWD', 6, 4, 4, 1, 'WF0JXXGAHJLE32654', 'images/cars/ford_fiesta.png', 'https://www.autocentrum.pl/ford/fiesta/viii/hatchback-5d/silnik-benzynowy-1.0-ecoboost-100km-2017-2020/', 'Usiądź za kierownicą Forda Fiesta i poznaj inteligentne technologie ułatwiające jazdę - np. wspomaganie parkowania, aktywny tempomat, rozpoznawanie znaków drogowych czy system wspomagający utrzymanie pojazdu na pasie ruchu. Przygotuj się na technologie, z którymi każdy kilometr podróży staje się czystą przyjemnością.'),
(28, 8.3, 5.3, 640, 5, 'AUTOMATYCZNA', 1498, 150, 'FWD', 8, 4, 4, 1, 'TMBJU7NE3K0156218', 'images/cars/skoda_octavia.png', 'https://www.autocentrum.pl/skoda/octavia/iv/kombi/silnik-benzynowy-1.5-tsi-150km-od-2020/', 'Całkowicie nowa, jeszcze bardziej przestronna Octavia Combi pomieści całą rodzinę. Auto posiada mnóstwo miejsca dla wszytskich pasażerów, a także przepastny bagażnik. Nowa stylistyka pozwala cieszyć się najwyższą jakością elegancji.'),
(29, 13.7, 7, 332, 2, 'Automatyczna', 2261, 290, 'RWD', 8, 2, 2, 1, '1FATP8UH9K5151163', 'images/cars/ford_mustang_290.png', 'https://www.autocentrum.pl/ford/mustang/vi/convertible-facelifting/silnik-benzynowy-2.3-ecoboost-290km-od-2018/', 'Wprowadzona na rynek w roku 2014 najnowsza i obecnie produkowana, szósta generacja modelu, jest największym w dotychczasowej historii Mustanga przełomem – jest pierwszym Mustangiem oferowanym oficjalnie na Starym Kontynencie. Stało się to za sprawą fordowskiej strategii „One Ford”. Już w roku 2009 ruszyły prace na tym modelem, który korzysta ze stylistycznych rozwiązań prototypu Evos z roku 2011, w przeciwieństwie natomiast do swoich poprzedników, jest oparty konstrukcyjnie na nowych rozwiązaniach, które zostały opracowane właśnie dla nowego Mustanga.'),
(30, 6.6, 4.9, 402, 5, 'MANUALNA', 1332, 140, 'FWD', 8, 4, 1, 1, 'VF1RFB00765487693', 'images/cars/renault_megane.png', 'https://www.autocentrum.pl/renault/megane/iv/hatchback-5d-facelifting/silnik-benzynowy-1.3-tce-140km-od-2020/', 'Debiutująca na rynku w roku 2016, obecnie produkowana, czwarta generacja modelu jest następną rewolucją stylistyczną. Megane IV został zaprojektowany według nowej koncepcji designu francuskiej marki, której skorzystano wcześniej w modelach Captur, Clio IV generacji oraz Espace V generacji. Renault Megane czwartej generacji powstało na platformie podłogowej CMF-CD, będącej owocem współpracy Renault i Nissana, na której zbudowane są także Nissan Quashqai oraz Renault Talisman. Samochód oferowany jest w wariantach: hatchback, kombi oraz sedan (powracający do oferty, jako że w przypadku trzeciej generacji Megane, był on autonomicznym modelem o nazwie Fluence). Wersję usportowioną auta nazwano Renault Megane GT.'),
(31, 5.4, 3.9, 530, 5, 'MANUALNA', 999, 110, 'FWD', 6, 2, 1, 1, 'TMBJR6NJ9MZ018870', 'images/cars/skoda_fabia.png', 'https://www.autocentrum.pl/skoda/fabia/iii/kombi-facelifting/silnik-benzynowy-1.0-tsi-110km-od-2018/', 'Skoda Fabia trzeciej generacji światową premierę miała podczas wystawy samochodowej w Paryżu jesienią 2014 r. Model ten powstał na platformie PQ25, na której zbudowano m.in. takie modele jak Skoda Rapid, Seat Ibiza, Volkswagen Polo czy Audi A1. Skoda Fabia III dostępna jest jako pięciodrzwiowy hatchback oraz nieco większa odmiana kombi. W 2018 r. Fabia trzeciej generacji została poddana faceliftingowi, w ramach którego zmodernizowano przede wszystkim przednią część nadwozia.'),
(32, 3.9, 3.2, 290, 3, 'MANUALNA', 1498, 120, 'FWD', 6, 2, 2, 1, 'WF0JXXGAHJLL39528', 'images/cars/ford_fiesta.png', 'https://www.autocentrum.pl/ford/fiesta/viii/hatchback-3d/silnik-diesla-1.5-tdci-120km-2017-2019/', 'Usiądź za kierownicą Forda Fiesta i poznaj inteligentne technologie ułatwiające jazdę - np. wspomaganie parkowania, aktywny tempomat, rozpoznawanie znaków drogowych czy system wspomagający utrzymanie pojazdu na pasie ruchu. Przygotuj się na technologie, z którymi każdy kilometr podróży staje się czystą przyjemnością.'),
(33, 5.8, 4.6, 382, 5, 'AUTOMATYCZNA', 998, 72, 'FWD', 8, 2, 2, 1, 'VNKKD3D360A634580', 'images/cars/toyota_yaris.png', 'https://www.autocentrum.pl/toyota/yaris/iv/hatchback/silnik-benzynowy-1.0-vvt-i-72km-od-2019/', 'Nowy Yaris łączy zaawansowany napęd benzynowy z dynamiczną stylistyką oraz świetnie sprawdza się zarówno w mieście, jak i na autostradzie. Samochód został oparty na innowacyjnej platformie projektowej TNGA i posiada najnowsze systemy bezpieczeństwa. Razem daje to piorunujący efekt.'),
(34, 8.2, 6.5, 500, 4, 'AUTOMATYCZNA', 1969, 235, 'AWD', 12, 4, 4, 1, 'LVYPS68UCLP084007', 'images/cars/volvo_s90.png', 'https://www.autocentrum.pl/volvo/s90/ii/sedan-facelifting/silnik-diesla-2.0-d5-235km-2020/', 'Żyj po swojemu Kontroluj każdy kilometr drogi dzięki intuicyjnym rozwiązaniom zwiększającym komfort jazdy. Wyróżnij się odświeżonym wyglądem nadwozia, nowymi chromowanymi detalami i grillem. Zarówno na przednich, jak i tylnych fotelach masz mnóstwo miejsca na nogi, a wyjątkowo miękka i delikatna skóra nappa jeszcze bardziej podnosi poziom luksusu. Środkowy podłokietnik składa się w dół, aby zapewnić Ci jeszcze lepsze warunki odpoczynku w długiej trasie.'),
(35, 5.8, 4.5, 417, 4, 'AUTOMATYCZNA', 999, 125, 'FWD', 8, 4, 1, 1, 'WF0NXXGCHNLL35125', 'images/cars/ford_focus_sedan.png', 'https://www.autocentrum.pl/ford/focus/iv/sedan/silnik-benzynowy-1.0-ecoboost-125km-od-2020/', 'Przedstawiamy wyjątkowego, zupełnie Forda Focus, zaprojektowanego tak, aby każda podróż była łatwiejsza, bezpieczniejsza i przyjemniejsza. Wyposażono go w szereg zaawansowanych rozwiązań technicznych zaprojektowanych specjalnie z myślą o użytkownikach. Począwszy od wielokrotnie nagradzanych systemów łączności, takich jak Ford SYNC 3, po zaawansowane systemy wspomagające kierowcę, które z Tobą współpracują - wszystkie one sprawiają, że podróżowanie staje się łatwiejsze.'),
(36, 14, 12, 505, 4, 'AUTOMATYCZNA', 3996, 460, 'AWD', 12, 4, 4, 1, 'WAUZZZF80JN014240', 'images/cars/audi_a8.png', 'https://www.autocentrum.pl/audi/a8/d5/sedan/silnik-benzynowy-4.0-60-tfsi-460km-od-2020/', 'Stylistyka wyznaczająca początek nowej ery dla marki Audi. 41 inteligentnych systemów Audi AI wspierających kierowcę podczas jazdy. Nowy poziom intuicyjnej obsługi za pomocą dotykowych ekranów i głosu. Perfekcyjnie zaprojektowane i wykonane wnętrze, gwarantujące najwyższy komfort podróżowania. Audi A8 na nowo definiuje limuzynę klasy Premium i wyznacza kierunek rozwoju współczesnej motoryzacji.'),
(37, 7.2, 5.2, 480, 4, 'AUTOMATYCZNA', 1998, 184, 'RWD', 10, 4, 4, 1, 'WBA5P91080FK50472', 'images/cars/bmw_seria3.png', 'https://www.autocentrum.pl/bmw/seria-3/g20-g21/limuzyna/silnik-benzynowy-2.0-320i-184km-od-2019/', 'Nowe BMW serii 3 Limuzyna pozostawia wszystkich w tyle, również konwencje i oczekiwania. Ikona znów pokazuje jak ulepszać się od nowa. W końcu, dzięki pionierskiemu językowi designu, tłumaczy początek nowej ery. Napęd wyjątkowej limuzyny sportowej to jeszcze mocniejsze i wydajniejsze silniki.'),
(38, 18, 11, 171, 2, 'AUTOMATYCZNA', 6162, 659, 'RWD', 6, 2, 2, 1, '1G1Y72D49L5105563', 'images/cars/chevrolet_corvette.png', 'https://www.autocentrum.pl/chevrolet/corvette/c7/convertible/silnik-benzynowy-6.2-v8-z06-659km-od-2014/', 'Siódma generacja Corvette przeszła gruntowną zmianę formuły, zyskując nie tylko nowy projekt stylistyczny, ale i nowe proporcje nadwozia. Samochód zyskał znacznie masywniejszą i bardziej muskularną. sylwetkę, z dużym wlotem powietrza w przedniej części nadwozia i większymi, agresywnie zarysowanymi reflektorami');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `object_repr` varchar(200) COLLATE utf8mb4_polish_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_polish_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_polish_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_polish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_polish_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_polish_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2021-01-04 18:12:09.000000'),
(2, 'auth', '0001_initial', '2021-01-04 18:12:12.000000'),
(3, 'admin', '0001_initial', '2021-01-04 18:12:35.000000'),
(4, 'admin', '0002_logentry_remove_auto_add', '2021-01-04 18:12:45.000000'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2021-01-04 18:12:45.000000'),
(6, 'contenttypes', '0002_remove_content_type_name', '2021-01-04 18:12:47.000000'),
(7, 'auth', '0002_alter_permission_name_max_length', '2021-01-04 18:12:54.000000'),
(8, 'auth', '0003_alter_user_email_max_length', '2021-01-04 18:12:54.000000'),
(9, 'auth', '0004_alter_user_username_opts', '2021-01-04 18:12:54.000000'),
(10, 'auth', '0005_alter_user_last_login_null', '2021-01-04 18:12:57.000000'),
(11, 'auth', '0006_require_contenttypes_0002', '2021-01-04 18:12:57.000000'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2021-01-04 18:12:57.000000'),
(13, 'auth', '0008_alter_user_username_max_length', '2021-01-04 18:12:58.000000'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2021-01-04 18:12:59.000000'),
(15, 'auth', '0010_alter_group_name_max_length', '2021-01-04 18:12:59.000000'),
(16, 'auth', '0011_update_proxy_permissions', '2021-01-04 18:12:59.000000'),
(17, 'sessions', '0001_initial', '2021-01-04 18:13:00.000000'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2021-01-28 15:45:13.000000');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_polish_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_polish_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('btyz6nup34bphcgz47oh6mwv92wjp5hq', 'YzQxY2M4MGMwNWZiMzVmODA0ZjFiOWVhOGJjMWU5ZDVkYjcwODA5NDp7InRlc2NpayI6InJhemR3YXRyenkifQ==', '2021-01-18 19:06:01.000000'),
('d6jdgr888wyh7eoy43fi1s3y2ox8z59j', 'MmQyOTBkOTlkMGYzMDZiYjhhMmYyMGRmZTRlOWMyMDFjMDAwMGYxMTp7InBpY2siOiIyMDIxLTAxLTE1IiwicmV0dXJuIjoiMjAyMS0wMS0xNiIsImJhc2ljX3ByaWNlIjoxNTAwLCJkZXBvc2l0X3ByaWNlIjozMDAwLCJwYWNrZXQtaWQiOjMsInBhY2tldC1uYW1lIjoiUm96c3plcnpvbnkgRVUiLCJwYWNrZXQtcHJpY2UiOjk5LCJleHRyYV9zZWF0X3ByaWNlIjowLCJpZl9hYnJvYWRfcHJpY2UiOjAsImlmX21vcmVfdXNlcnNfcHJpY2UiOjAsInVzZXJfaWQiOjIsImNhcl9pZCI6MzUsIm9yZGVyX2lkIjoyfQ==', '2021-01-29 21:00:29.000000'),
('pwwanqb43b2p4l7o3h6a1eagauq6y0ju', '.eJxdjtEKwjAMRX9F-rxBO4eoXyH-QMnaiEVcR9oxV_HfTXWbw7dwTnJvniJiMO4mjoIg2QEipVEUonMms0pWqpSqrPbMCGNP7Zoe8iaYG8bSXFmcfQoJKfl23NRZ4iMS6IAQP2dM3EVDQx4sg3oCd0-o-4AUGCr5C23hjoxO3oYIgx_Gn-rIGXZy3aEnWMlVzwxr-dc1CyWXUMdfqUI0EJyZ9YG1xc4Ht-RvJbOcofPBrhAGvmOO8mRn8XoDkVhwEg:1l59TW:RfhciVGG8DK7Hu7XsRjPO8CXY8yhuluJVMN6w_ebt7Y', '2021-02-11 15:44:50.000000');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `door_to_door`
--

CREATE TABLE `door_to_door` (
  `OrderID` int(11) NOT NULL,
  `Street` varchar(20) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `HouseNumber` varchar(6) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `FlatNumber` varchar(6) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `PostCode` varchar(10) COLLATE utf8mb4_polish_ci DEFAULT NULL,
  `City` varchar(20) COLLATE utf8mb4_polish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Zrzut danych tabeli `door_to_door`
--

INSERT INTO `door_to_door` (`OrderID`, `Street`, `HouseNumber`, `FlatNumber`, `PostCode`, `City`) VALUES
(1, 'Green Valey', '2', '4', '54-310', 'Wrocław'),
(2, 'Zielonogórska 19/10', '', '', '53-617', 'Wrocław'),
(3, 'Krapkowicka', '11', '2', '54-310', 'Hollywood'),
(4, 'Opolska', '65', '12', '54-310', 'Wrocław'),
(5, '', '', '', '', ''),
(6, 'Green Valey', '23', '12', '54-211', 'Włochy');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `insurance_packet`
--

CREATE TABLE `insurance_packet` (
  `InsuranceID` int(11) NOT NULL,
  `InsuranceName` varchar(64) COLLATE utf8_polish_ci DEFAULT NULL,
  `InsuranceDescription` varchar(1024) COLLATE utf8_polish_ci NOT NULL,
  `InsurancePrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `insurance_packet`
--

INSERT INTO `insurance_packet` (`InsuranceID`, `InsuranceName`, `InsuranceDescription`, `InsurancePrice`) VALUES
(1, 'Podstawowy', 'Zawiera OC, AC i NNW.', 0),
(2, 'Rozszerzony', 'OC, AC, NNW. Zniesienie udziału własnego w szkodach z AC z 2000zł na 0zł. Pakiet Bezpieczeństwa - holowanie i samochód zastępczy w cenie. Ochrona szyb, felg i opon. Ubezpieczenie obejmuje wynajem tylko na terenie Polski.', 49),
(3, 'Rozszerzony EU', 'OC, AC, NNW. Zniesienie udziału własnego w szkodach z AC z 2000zł na 0zł. Pakiet Bezpieczeństwa - holowanie i samochód zastępczy w cenie. Ochrona szyb, felg i opon. Ubezpieczenie obejmuje wynajem na terenie całej Unii Europejskiej.', 99);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  `CarID` int(11) NOT NULL,
  `OrderNumber` int(11) NOT NULL,
  `WhenOrdered` datetime NOT NULL,
  `RentalDays` int(11) NOT NULL,
  `RentalStart` date NOT NULL,
  `RentalEnd` date NOT NULL,
  `IfAbroad` tinyint(1) NOT NULL,
  `IfPaid` tinyint(1) NOT NULL,
  `RentalPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`OrderID`, `UserID`, `CarID`, `OrderNumber`, `WhenOrdered`, `RentalDays`, `RentalStart`, `RentalEnd`, `IfAbroad`, `IfPaid`, `RentalPrice`) VALUES
(1, 1, 14, 390365, '2021-01-14 19:02:26', 13, '2021-01-19', '2021-02-01', 1, 1, 6920),
(2, 2, 35, 151408, '2021-01-15 21:58:49', 6, '2021-01-21', '2021-01-27', 1, 1, 1319),
(3, 3, 34, 261096, '2021-01-17 11:05:31', 5, '2021-01-26', '2021-01-31', 1, 1, 3399),
(4, 4, 28, 916360, '2021-01-21 17:23:51', 5, '2021-01-26', '2021-01-31', 1, 1, 1359),
(5, 5, 1, 345146, '2021-01-28 12:56:08', 1, '2021-01-28', '2021-01-29', 1, 1, 460),
(6, 6, 10, 794940, '2021-01-28 16:44:49', 1, '2021-01-28', '2021-01-29', 1, 1, 460);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `prices_for_additional_services`
--

CREATE TABLE `prices_for_additional_services` (
  `OrderId` int(11) NOT NULL,
  `UsingAbroad` int(11) DEFAULT NULL,
  `ChildSeat` int(11) DEFAULT NULL,
  `UsedByMoreUsers` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `prices_for_additional_services`
--

INSERT INTO `prices_for_additional_services` (`OrderId`, `UsingAbroad`, `ChildSeat`, `UsedByMoreUsers`) VALUES
(1, 40, 20, 10),
(2, 40, 0, 10),
(3, 40, 0, 10),
(4, 40, 20, 0),
(5, 40, 20, 10),
(6, 40, 20, 10);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `segment_price`
--

CREATE TABLE `segment_price` (
  `SegmentID` int(11) NOT NULL,
  `Segment` enum('A','B','C','C+','D','E','F','S') COLLATE utf8_polish_ci NOT NULL,
  `DepositPrice` int(11) DEFAULT NULL,
  `BasicPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `segment_price`
--

INSERT INTO `segment_price` (`SegmentID`, `Segment`, `DepositPrice`, `BasicPrice`) VALUES
(1, 'A', 300, 90),
(2, 'B', 300, 100),
(3, 'C', 500, 120),
(4, 'C+', 500, 150),
(5, 'D', 700, 220),
(6, 'E', 1000, 450),
(7, 'F', 2000, 900),
(8, 'S', 3000, 1500);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(15) COLLATE utf8_polish_ci NOT NULL,
  `Surname` varchar(15) COLLATE utf8_polish_ci NOT NULL,
  `Email` varchar(30) COLLATE utf8_polish_ci NOT NULL,
  `Phone` varchar(12) COLLATE utf8_polish_ci NOT NULL,
  `Age` int(11) NOT NULL,
  `Sex` enum('MAN','WOMAN') COLLATE utf8_polish_ci DEFAULT NULL,
  `DriverLicenceCat` varchar(4) COLLATE utf8_polish_ci NOT NULL,
  `SinceWhenDriverLicence` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`UserID`, `Name`, `Surname`, `Email`, `Phone`, `Age`, `Sex`, `DriverLicenceCat`, `SinceWhenDriverLicence`) VALUES
(1, 'Tomasz', 'Nadrowski', 'nadrowskia2@gmail.com', '424242421', 23, 'MAN', 'B', 5),
(2, 'Tomasz', 'Nadrowski', 'nadrowskia2@gmail.com', '+48723559839', 21, 'MAN', 'B', 2),
(3, 'Eden', 'Mark', 'nadrowskia2@gmail.com', '123123123', 24, 'MAN', 'B', 5),
(4, 'Tomasz', 'Carlos', 'caviko2021@loopsnow.com', '123123213', 21, 'MAN', 'B', 3),
(5, 'Tomasz', 'Nadrowski', 'nadrowskia2@gmail.com', '123123123', 21, 'MAN', 'B', 2),
(6, 'Tomasz', 'Jan', 'nadrowskia2@gmail.com', '123213123', 21, 'MAN', 'B', 2);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `accidents`
--
ALTER TABLE `accidents`
  ADD KEY `UserID` (`UserID`);

--
-- Indeksy dla tabeli `additional_services`
--
ALTER TABLE `additional_services`
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `InsuranceID` (`InsuranceID`);

--
-- Indeksy dla tabeli `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksy dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indeksy dla tabeli `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indeksy dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indeksy dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indeksy dla tabeli `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`CarID`),
  ADD KEY `SegmentID` (`SegmentID`);

--
-- Indeksy dla tabeli `cars_detail`
--
ALTER TABLE `cars_detail`
  ADD KEY `CarID` (`CarID`);

--
-- Indeksy dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indeksy dla tabeli `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indeksy dla tabeli `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indeksy dla tabeli `door_to_door`
--
ALTER TABLE `door_to_door`
  ADD KEY `OrderID` (`OrderID`);

--
-- Indeksy dla tabeli `insurance_packet`
--
ALTER TABLE `insurance_packet`
  ADD PRIMARY KEY (`InsuranceID`);

--
-- Indeksy dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `CarID` (`CarID`);

--
-- Indeksy dla tabeli `prices_for_additional_services`
--
ALTER TABLE `prices_for_additional_services`
  ADD KEY `OrderId` (`OrderId`);

--
-- Indeksy dla tabeli `segment_price`
--
ALTER TABLE `segment_price`
  ADD PRIMARY KEY (`SegmentID`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT dla tabeli `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `cars`
--
ALTER TABLE `cars`
  MODIFY `CarID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT dla tabeli `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT dla tabeli `insurance_packet`
--
ALTER TABLE `insurance_packet`
  MODIFY `InsuranceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT dla tabeli `segment_price`
--
ALTER TABLE `segment_price`
  MODIFY `SegmentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `accidents`
--
ALTER TABLE `accidents`
  ADD CONSTRAINT `accidents_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Ograniczenia dla tabeli `additional_services`
--
ALTER TABLE `additional_services`
  ADD CONSTRAINT `additional_services_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `additional_services_ibfk_2` FOREIGN KEY (`InsuranceID`) REFERENCES `insurance_packet` (`InsuranceID`),
  ADD CONSTRAINT `additional_services_ibfk_3` FOREIGN KEY (`InsuranceID`) REFERENCES `insurance_packet` (`InsuranceID`);

--
-- Ograniczenia dla tabeli `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Ograniczenia dla tabeli `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Ograniczenia dla tabeli `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`SegmentID`) REFERENCES `segment_price` (`SegmentID`);

--
-- Ograniczenia dla tabeli `cars_detail`
--
ALTER TABLE `cars_detail`
  ADD CONSTRAINT `cars_detail_ibfk_1` FOREIGN KEY (`CarID`) REFERENCES `cars` (`CarID`);

--
-- Ograniczenia dla tabeli `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Ograniczenia dla tabeli `door_to_door`
--
ALTER TABLE `door_to_door`
  ADD CONSTRAINT `door_to_door_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`);

--
-- Ograniczenia dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`CarID`) REFERENCES `cars` (`CarID`);

--
-- Ograniczenia dla tabeli `prices_for_additional_services`
--
ALTER TABLE `prices_for_additional_services`
  ADD CONSTRAINT `prices_for_additional_services_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
