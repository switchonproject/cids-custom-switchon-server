--
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.3
-- Dumped by pg_dump version 9.3.1
-- Started on 2014-06-25 14:40:19

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- TOC entry 3729 (class 0 OID 212229)
-- Dependencies: 297
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY contact (id, name, organisation, description, email, url) FROM stdin;
56	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
57	\N	SMHI	\N	lena.stromback@smhi.se	\N
58	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
59	\N	SMHI	\N	lena.stromback@smhi.se	\N
60	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
61	\N	SMHI	\N	lena.stromback@smhi.se	\N
62	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
63	\N	SMHI	\N	lena.stromback@smhi.se	\N
64	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
65	\N	SMHI	\N	lena.stromback@smhi.se	\N
66	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
67	\N	SMHI	\N	lena.stromback@smhi.se	\N
68	\N	SMHI	Point of contact	lena.stromback@smhi.se	\N
69	\N	SMHI	\N	lena.stromback@smhi.se	\N
\.


--
-- TOC entry 3723 (class 0 OID 211989)
-- Dependencies: 272
-- Data for Name: geom; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY geom (id, geo_field) FROM stdin;
2	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
3	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
4	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
5	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
6	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
7	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
8	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
9	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
10	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
11	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
12	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
13	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
14	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
15	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
16	01030000000100000005000000A4703D0AD7A326C052B81E85EBB14540A4703D0AD7A326C048E17A14AE6752407B14AE47E13A454048E17A14AE6752407B14AE47E13A454052B81E85EBB14540A4703D0AD7A326C052B81E85EBB14540
20	01030000000100000005000000126BF12900A626C07DAEB6627FB14540B3EF8AE07F3B45407DAEB6627FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C07DAEB6627FB14540
21	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
22	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
23	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
24	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
25	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
26	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
27	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
28	01030000000100000005000000126BF12900D623C00000000000C84540A18499B67F9545400000000000C84540A18499B67F954540774A07EBFF725240126BF12900D623C0774A07EBFF725240126BF12900D623C00000000000C84540
31	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
32	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
33	01030000000100000005000000126BF12900D623C00000000000C84540A18499B67F9545400000000000C84540A18499B67F954540774A07EBFF725240126BF12900D623C0774A07EBFF725240126BF12900D623C00000000000C84540
34	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
35	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
36	01030000000100000005000000126BF12900A626C07DAEB6627FB14540B3EF8AE07F3B45407DAEB6627FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C07DAEB6627FB14540
37	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
38	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
39	01030000000100000005000000126BF12900A626C000000000002840402A3A92CB7FD0464000000000002840402A3A92CB7FD046403CA583F57F5C5240126BF12900A626C03CA583F57F5C5240126BF12900A626C00000000000284040
40	01030000000100000005000000126BF12900D623C00000000000C84540A18499B67F9545400000000000C84540A18499B67F954540774A07EBFF725240126BF12900D623C0774A07EBFF725240126BF12900D623C00000000000C84540
41	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
42	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
43	01030000000100000005000000126BF12900A626C07DAEB6627FB14540B3EF8AE07F3B45407DAEB6627FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C07DAEB6627FB14540
44	01030000000100000005000000126BF12900A626C0A18499B67FB14540B3EF8AE07F3B4540A18499B67FB14540B3EF8AE07F3B4540D97745F0BF675240126BF12900A626C0D97745F0BF675240126BF12900A626C0A18499B67FB14540
\.


--
-- TOC entry 3738 (class 0 OID 212405)
-- Dependencies: 306
-- Data for Name: relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY relationship (id, name, description, tags, fromresource, toresource, metadata) FROM stdin;
\.


--
-- TOC entry 3727 (class 0 OID 212199)
-- Dependencies: 295
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tag (id, name, description, taggroup) FROM stdin;
2	biota	\N	2
3	boundries	\N	3
4	climatologyMeterologyAtmosphere	\N	4
5	economy	\N	5
6	elevation	\N	6
7	environment	\N	7
8	farming	\N	8
9	geoscientificInformation	\N	9
10	health	\N	10
11	imageryBaseMapsEarthCover	\N	11
12	inlandWaters	\N	12
13	intelligenceMilitary	\N	13
14	location	\N	14
15	oceans	\N	15
16	planningCadastre	\N	16
17	society	\N	17
18	structure	\N	18
19	transportation	\N	19
20	utilitiesCommunication	\N	20
21	no limitation	no limitation	21
22	(a) the confidentiality...	(a) the confidentiality of the proceedings of public authorities, where such confidentiality is provided for by law	22
23	(b) international relations...	(b) international relations, public security or national defence	23
24	(c) the course...	(c) the course of justice, the ability of any person to receive a fair trial or the ability of a public authority to conduct an enquiry of a criminal or disciplinary nature	24
25	(d) the confidentiality...	(d) the confidentiality of commercial or industrial information, where such confidentiality is provided for by national or Community law to protect a legitimate economic interest, including the public interest in maintaining statistical confidentiality and tax secrecy	25
26	(e) intellectual property rights	(e) intellectual property rights	26
27	(f) the confidentiality...	(f) the confidentiality of personal data and/or files relating to a natural person where that person has not consented to the disclosure of the information to the public, where such confidentiality is provided for by national or Community law	27
28	(g) the interests...	(g) the interests or protection of any person who supplied the information requested on a voluntary basis without being under, or capable of being put under, a legal obligation to do so, unless that person has consented to the release of the information concerned	28
29	(h) the protection	(h) the protection of the environment to which such information relates, such as the location of rare species.	29
30	Addresses	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	30
31	Administrative units	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	31
32	Agricultural and aquaculture facilities	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	32
33	Area management/restriction/regulation zones and reporting units	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	33
34	Atmospheric conditions	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	34
35	Bio-geographic regions	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	35
36	Buildings	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	36
37	Cadastral parcels	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	37
38	Coordinate reference systems	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	38
39	Elevation	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	39
40	Energy resources	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	40
41	Environmental monitoring facilities	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	41
42	Geographical grid systems	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	42
43	Geographical names	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	43
44	Geology	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	44
45	Habitats and biotopes	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	45
46	Human health and safety	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	46
47	Hydrography	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	47
48	Land cover	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	48
49	Land use	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	49
50	Meteorological geographical features	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	50
51	Mineral resources	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	51
52	Natural risk zones	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	52
53	Oceanographic geographical features	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	53
54	Orthoimagery	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	54
55	Population distribution - demography	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	55
56	Production and industrial facilities	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	56
57	Protected sites	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	57
58	Sea regions	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	58
59	Soil	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	59
60	Species distribution	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	60
61	Statistical units	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	61
62	Transport networks	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	62
63	Utility and govermental services	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01	63
64	bul	Bulgarian	64
65	cze	Czech	65
66	dan	Danish	66
67	dut	Dutch	67
68	eng	English	68
69	fin	Finnish	69
70	fre	French	70
71	ger	German	71
72	gre	Greek	72
73	hun	Hungarian	73
74	gle	Irish	74
75	ita	Italian	75
76	pol	Polish	76
77	por	Portuguese	77
78	slo	Slovak	78
79	spa	Spanish	79
80	swe	Swedish	80
81	CC BY	Creative Commons Attribution 4.0 International (CC BY 4.0) http://creativecommons.org/licenses/by/4.0/legalcode	81
82	CC BY-SA	Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0) http://creativecommons.org/licenses/by-sa/4.0/legalcode	82
83	CC BY-ND	Creative Commons Attribution-NoDerivatives 4.0 International (CC BY-ND 4.0) http://creativecommons.org/licenses/by-nd/4.0/legalcode	83
84	CC BY-NC	Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) http://creativecommons.org/licenses/by-nc/4.0/	84
85	CC BY-NC-SA	Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode	85
86	CC BY-NC-ND	Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0) http://creativecommons.org/licenses/by-nc-nd/4.0/legalcode	86
87	ODbL	Open Database License (ODbL) v1.0 http://opendatacommons.org/licenses/odbl/1.0/	87
88	DbCL	Database Contents License (DbCL) v1.0 http://opendatacommons.org/licenses/dbcl/1.0/	88
89	PDDL	ODC Public Domain Dedication and Licence (PDDL) http://opendatacommons.org/licenses/pddl/1.0/	89
90	ODC-By	Open Data Commons Attribution License (ODC-By) v1.0 http://opendatacommons.org/licenses/by/1.0/	90
91	Land-use	\N	91
92	Modelled river discharge	\N	92
93	Observed river discharge	\N	93
94	PotEvapo	\N	94
95	Precipitation	\N	95
96	Soils	\N	96
97	Subbasins	\N	97
98	Temperature	\N	98
99	South Tyne	\N	99
100	Waveney	\N	100
101	Wylye	\N	101
102	Dyfi	\N	102
103	Hoan	\N	103
104	Juktan	\N	104
105	Nossan	\N	105
106	Gadera	\N	106
107	Tanaro	\N	107
108	Arno	\N	108
109	Vils	\N	109
110	Grossarl	\N	110
111	Kreuzbergmauth	\N	111
112	Furtmuehle	\N	112
113	Fluttendorf	\N	113
114	Wieselburg	\N	114
115	Broye	\N	115
116	Ioisach	\N	116
117	Treene	\N	117
118	Level A	Pan Europe	118
119	Level B	Selected Subbasins	119
\.


--
-- TOC entry 3732 (class 0 OID 212276)
-- Dependencies: 300
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resource (id, uuid, name, description, tags, spatialcoverage, fromdate, todate, creationdate, publicationdate, lastmodificationdate, contact, representation, license, metadata) FROM stdin;
14	switchon.waterlaboratories.discharge.e-hype25	River discharge	Time series descriping modeled river discharge for each E-HYPE subbasin. The data describes daily values for each subbasin. Unit of measurement: m3/s	14	38	1961-01-01 00:00:00	2001-12-31 00:00:00	\N	2014-02-10 00:00:00	\N	56	14	\N	14
15	switchon.waterlaboratories.landuse.e-hype25	Land-use on subbasins	Land use based on subbasin division. The data shows proportions of land-use for each land-use class and subbasin.Unit of measurement: %	15	39	1961-01-01 00:00:00	2001-12-31 00:00:00	\N	2014-02-10 00:00:00	\N	58	15	\N	15
16	switchon.waterlaboratories.precipitation.e-hype25	Corrected precipitation	Time series descriping corrected presipitation for each E-HYPE subbasin. The data describes daily values for each subbasin.Unit of measurement: mm	16	40	1961-01-01 00:00:00	2001-12-31 00:00:00	\N	2014-02-10 00:00:00	\N	60	16	\N	16
17	switchon.waterlaboratories.obsdischarge.e-hype25	Observed discharge	Positions for gauging stations in Europe. Locations adjusted according to E-HYPE2.5 subbasin division.	17	41	\N	\N	\N	2014-02-10 00:00:00	\N	62	17	\N	17
18	switchon.waterlaboratories.soils.e-hype25	Soils on subbasins	Soils based on subbasin division. The data shows proportions of soil classes for each land-use class and subbasin.Unit of measurement: %	18	42	\N	\N	\N	2014-02-10 00:00:00	\N	64	18	\N	18
19	switchon.waterlaboratories.subbasin.e-hype25	Subbasin division	Polygons and links between them has been developed at SMHI based on the hydrological corrected databases Hydrosheds and Hydro1K with some manual adjustments and quality control against published values of catchment areas for European gauging stations.	19	43	\N	\N	\N	2014-02-10 00:00:00	\N	66	19	\N	19
20	switchon.waterlaboratories.temperature.e-hype25	Corrected temperature	Time series descriping corrected air temperature for each E-HYPE subbasin. The data describes daily values for each subbasin.Unit of measurement: degress Celsius	20	44	1961-01-01 00:00:00	2001-12-31 00:00:00	\N	2014-02-10 00:00:00	\N	68	20	\N	20
\.


--
-- TOC entry 3741 (class 0 OID 212471)
-- Dependencies: 309
-- Data for Name: jt_fromresource_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_fromresource_relationship (id, resid, relationship_reference) FROM stdin;
\.


--
-- TOC entry 3730 (class 0 OID 212238)
-- Dependencies: 298
-- Data for Name: metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metadata (id, name, tags, description, contact, creationdate, contenttype, contentlocation, content) FROM stdin;
38	Discharge(EHYPEv2pt5)metadata.xml	38		57	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SFpRNWtodFJUY00	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>discharge.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>River discharge</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>discharge.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Time series descriping modeled river discharge for each E-HYPE subbasin. The data describes daily values for each subbasin. Unit of measurement: m3/s</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>45.6289</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>32.3125</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.44531</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t\t<gml:beginPosition>1961-01-01</gml:beginPosition>\n\t\t\t\t\t\t\t\t\t<gml:endPosition>2001-12-31</gml:endPosition>\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>River discharge simulation with E-HYPE v 2.5 using WATCH forcing data.</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
39	Land-use(EHYPEv2pt5)metadata.xml	39		59	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SkFsdmdmaHgtUVk	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>discharge.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>River discharge</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>discharge.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Time series descriping modeled river discharge for each E-HYPE subbasin. The data describes daily values for each subbasin. Unit of measurement: m3/s</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>45.6289</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>32.3125</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.44531</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t\t<gml:beginPosition>1961-01-01</gml:beginPosition>\n\t\t\t\t\t\t\t\t\t<gml:endPosition>2001-12-31</gml:endPosition>\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>River discharge simulation with E-HYPE v 2.5 using WATCH forcing data.</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
40	Precipitation(EHYPEv2pt5)metadata.xml	40		61	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SDR3dGhSREpwcFk	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>precipitation.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>Corrected precipitation</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>precipitation.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Time series descriping corrected presipitation for each E-HYPE subbasin. The data describes daily values for each subbasin.Unit of measurement: mm</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\t\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-9.91797</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.16796</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.5625</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.79687</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t\t<gml:beginPosition>1961-01-01</gml:beginPosition>\n\t\t\t\t\t\t\t\t\t<gml:endPosition>2001-12-31</gml:endPosition>\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\t\t\t\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>Original data source: WATCH Forcing Data 20th Century - Rainf_daily_WFD _GPCC +Snowf_daily_WFD_GPCC_ adjusted using E-HYPE2.5.Link to original data http://www.eu-watch.org/data_availability</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
41	River Gauges(EHYPEv2pt5)metadata.xml	41		63	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8ZEtveHc0WDlvNzg	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>obsdischarge.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>Observed discharge</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\t\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>obsdischarge.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Positions for gauging stations in Europe. Locations adjusted according to E-HYPE2.5 subbasin division.</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\t\t\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>42.46484</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.38671</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.62109</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\t\t\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>Station positions from GRDC and EWA</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
42	Soils(EHYPEv2pt5)metadata.xml	42		65	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8anBOenAxZDNmekk	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>soils.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>Soils on subbasins</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\t\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>soils.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Soils based on subbasin division. The data shows proportions of soil classes for each land-use class and subbasin.Unit of measurement: %</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Soil</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\t\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\t\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>42.46484</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.38671</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.62109</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>Based on Landuse_EHYPE_v2pt5,  Rice fields according to CLC2000 and GLC2000 Asia, and average subbasin elevation according to HYDOSHEDS/HYDRO1K.</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
43	Subbasin(EHYPEv2pt5)metadata.xml	43		67	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8X25DSFZEZ1ljNU0	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>subbasin.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>Subbasin division</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>subbasin.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Polygons and links between them has been developed at SMHI based on the hydrological corrected databases Hydrosheds and Hydro1K with some manual adjustments and quality control against published values of catchment areas for European gauging stations.</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>42.46484</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.38671</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.62109</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>Based on HYDOSHEDS http://hydrosheds.cr.usgs.gov/index.php\n\t\t\t\t\t\t\tand HYDRO1K https://lta.cr.usgs.gov/GTOPO30</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
44	Temperature(EHYPEv2pt5)metadata.xml	44		69	2014-02-05 00:00:00	application/xml	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8TUUzZ0I5OGhrNlE	<?xml version="1.0" encoding="UTF-8"?>\n<gmd:MD_Metadata xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.isotc211.org/2005/gmd http://schemas.opengis.net/iso/19139/20060504/gmd/gmd.xsd">\n\t<gmd:fileIdentifier>\n\t\t<gco:CharacterString>temperature.e-hype25</gco:CharacterString>\n\t</gmd:fileIdentifier>\n\t<gmd:language>\n\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t</gmd:language>\n\t<gmd:characterSet>\n\t\t<gmd:MD_CharacterSetCode codeSpace="ISOTC211/19115" codeListValue="MD_CharacterSetCode_utf8" codeList="http://www.isotc211.org/2005/resources/Codelist/gmxCodelists.xml#MD_CharacterSetCode">MD_CharacterSetCode_utf8</gmd:MD_CharacterSetCode>\n\t</gmd:characterSet>\n\t<gmd:hierarchyLevel>\n\t\t<gmd:MD_ScopeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode" codeListValue="dataset">dataset</gmd:MD_ScopeCode>\n\t</gmd:hierarchyLevel>\n\t<gmd:contact>\n\t\t<gmd:CI_ResponsibleParty>\n\t\t\t<gmd:organisationName>\n\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t</gmd:organisationName>\n\t\t\t<gmd:contactInfo>\n\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t</gmd:address>\n\t\t\t\t</gmd:CI_Contact>\n\t\t\t</gmd:contactInfo>\n\t\t\t<gmd:role>\n\t\t\t\t<gmd:CI_RoleCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_RoleCode" codeListValue="pointOfContact">pointOfContact</gmd:CI_RoleCode>\n\t\t\t</gmd:role>\n\t\t</gmd:CI_ResponsibleParty>\n\t</gmd:contact>\n\t<gmd:dateStamp>\n\t\t<gco:Date>2014-02-05</gco:Date>\n\t</gmd:dateStamp>\n\t<gmd:metadataStandardName>\n\t\t<gco:CharacterString>ISO19115</gco:CharacterString>\n\t</gmd:metadataStandardName>\n\t<gmd:metadataStandardVersion>\n\t\t<gco:CharacterString>2003/Cor.1:2006</gco:CharacterString>\n\t</gmd:metadataStandardVersion>\n\t<gmd:identificationInfo>\n\t\t<gmd:MD_DataIdentification>\n\t\t\t<gmd:citation>\n\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t<gco:CharacterString>Corrected temperature</gco:CharacterString>\n\t\t\t\t\t</gmd:title>\n\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gco:Date>2014-02-10</gco:Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t</gmd:date>\n\t\t\t\t\t<gmd:identifier>\n\t\t\t\t\t\t<gmd:RS_Identifier>\n\t\t\t\t\t\t\t<gmd:code>\n\t\t\t\t\t\t\t\t<gco:CharacterString>temperature.e-hype25</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:code>\n\t\t\t\t\t\t\t<gmd:codeSpace>\n\t\t\t\t\t\t\t\t<gco:CharacterString>switchon.waterlaboratories</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:codeSpace>\n\t\t\t\t\t\t</gmd:RS_Identifier>\n\t\t\t\t\t</gmd:identifier>\n\t\t\t\t</gmd:CI_Citation>\n\t\t\t</gmd:citation>\n\t\t\t<gmd:abstract>\n\t\t\t\t<gco:CharacterString>Time series descriping corrected air temperature for each E-HYPE subbasin. The data describes daily values for each subbasin.Unit of measurement: degress Celsius</gco:CharacterString>\n\t\t\t</gmd:abstract>\n\t\t\t<gmd:pointOfContact>\n\t\t\t\t<gmd:CI_ResponsibleParty>\n\t\t\t\t\t<gmd:organisationName>\n\t\t\t\t\t\t<gco:CharacterString>SMHI</gco:CharacterString>\n\t\t\t\t\t</gmd:organisationName>\n\t\t\t\t\t<gmd:contactInfo>\n\t\t\t\t\t\t<gmd:CI_Contact>\n\t\t\t\t\t\t\t<gmd:address>\n\t\t\t\t\t\t\t\t<gmd:CI_Address>\n\t\t\t\t\t\t\t\t\t<gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t\t\t<gco:CharacterString>lena.stromback@smhi.se</gco:CharacterString>\n\t\t\t\t\t\t\t\t\t</gmd:electronicMailAddress>\n\t\t\t\t\t\t\t\t</gmd:CI_Address>\n\t\t\t\t\t\t\t</gmd:address>\n\t\t\t\t\t\t</gmd:CI_Contact>\n\t\t\t\t\t</gmd:contactInfo>\n\t\t\t\t</gmd:CI_ResponsibleParty>\n\t\t\t</gmd:pointOfContact>\n\t\t\t<gmd:descriptiveKeywords>\n\t\t\t\t<gmd:MD_Keywords>\n\t\t\t\t\t<gmd:keyword>\n\t\t\t\t\t\t<gco:CharacterString>Hydrography</gco:CharacterString>\n\t\t\t\t\t</gmd:keyword>\n\t\t\t\t\t<gmd:thesaurusName>\n\t\t\t\t\t\t<gmd:CI_Citation>\n\t\t\t\t\t\t\t<gmd:title>\n\t\t\t\t\t\t\t\t<gco:CharacterString>GEMET - INSPIRE themes, version 1.0</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:title>\n\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t<gmd:CI_Date>\n\t\t\t\t\t\t\t\t\t<gmd:date>\n\t\t\t\t\t\t\t\t\t\t<gco:Date>2008-06-01</gco:Date>\t\n\t\t\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t\t\t\t<gmd:dateType>\n\t\t\t\t\t\t\t\t\t\t<gmd:CI_DateTypeCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#CI_DateTypeCode" codeListValue="publication">publication</gmd:CI_DateTypeCode>\n\t\t\t\t\t\t\t\t\t</gmd:dateType>\n\t\t\t\t\t\t\t\t</gmd:CI_Date>\n\t\t\t\t\t\t\t</gmd:date>\n\t\t\t\t\t\t</gmd:CI_Citation>\n\t\t\t\t\t</gmd:thesaurusName>\n\t\t\t\t</gmd:MD_Keywords>\n\t\t\t</gmd:descriptiveKeywords>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_Constraints>\n\t\t\t\t\t<gmd:useLimitation>\n\t\t\t\t\t\t<gco:CharacterString>Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)  http://creativecommons.org/licenses/by-sa/4.0/legalcode</gco:CharacterString>\n\t\t\t\t\t</gmd:useLimitation>\n\t\t\t\t</gmd:MD_Constraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:resourceConstraints>\n\t\t\t\t<gmd:MD_LegalConstraints>\n\t\t\t\t\t<gmd:accessConstraints>\n\t\t\t\t\t\t<gmd:MD_RestrictionCode codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_RestrictionCode" codeListValue="otherRestrictions">otherRestrictions</gmd:MD_RestrictionCode>\n\t\t\t\t\t</gmd:accessConstraints>\n\t\t\t\t\t<gmd:otherConstraints>\n\t\t\t\t\t\t<gco:CharacterString>no limitation</gco:CharacterString>\n\t\t\t\t\t</gmd:otherConstraints>\n\t\t\t\t</gmd:MD_LegalConstraints>\n\t\t\t</gmd:resourceConstraints>\n\t\t\t<gmd:language>\n\t\t\t\t<gmd:LanguageCode codeList="http://www.loc.gov/standards/iso639-2/" codeListValue="eng">eng</gmd:LanguageCode>\n\t\t\t</gmd:language>\n\t\t\t<gmd:topicCategory>\n\t\t\t\t<gmd:MD_TopicCategoryCode>inlandWaters</gmd:MD_TopicCategoryCode>\n\t\t\t</gmd:topicCategory>\n\t\t\t<gmd:extent>\n\t\t\t\t<gmd:EX_Extent>\t\t\n\t\t\t\t\t<gmd:geographicElement>\n\t\t\t\t\t\t<gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t\t\t<gmd:westBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>-11.32422</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:westBoundLongitude>\n\t\t\t\t\t\t\t<gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>42.46484</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:eastBoundLongitude>\n\t\t\t\t\t\t\t<gmd:southBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>43.38671</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:southBoundLatitude>\n\t\t\t\t\t\t\t<gmd:northBoundLatitude>\n\t\t\t\t\t\t\t\t<gco:Decimal>73.62109</gco:Decimal>\n\t\t\t\t\t\t\t</gmd:northBoundLatitude>\n\t\t\t\t\t\t</gmd:EX_GeographicBoundingBox>\n\t\t\t\t\t</gmd:geographicElement>\n\t\t\t\t\t<gmd:temporalElement>\n\t\t\t\t\t\t<gmd:EX_TemporalExtent>\n\t\t\t\t\t\t\t<gmd:extent>\n\t\t\t\t\t\t\t\t<gml:TimePeriod gml:id="IDcd3b1c4f-b5f7-439a-afc4-3317a4cd89be" xsi:type="gml:TimePeriodType">\n\t\t\t\t\t\t\t\t\t<gml:beginPosition>1961-01-01</gml:beginPosition>\n\t\t\t\t\t\t\t\t\t<gml:endPosition>2001-12-31</gml:endPosition>\n\t\t\t\t\t\t\t\t</gml:TimePeriod>\n\t\t\t\t\t\t\t</gmd:extent>\n\t\t\t\t\t\t</gmd:EX_TemporalExtent>\n\t\t\t\t\t</gmd:temporalElement>\n\t\t\t\t</gmd:EX_Extent>\t\t\n\t\t\t</gmd:extent>\n\t\t</gmd:MD_DataIdentification>\n\t</gmd:identificationInfo>\n\t<gmd:distributionInfo>\n\t\t<gmd:MD_Distribution>\n\t\t\t<gmd:distributionFormat>\n\t\t\t\t<gmd:MD_Format>\n\t\t\t\t\t<gmd:name>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:name>\n\t\t\t\t\t<gmd:version>\n\t\t\t\t\t\t<gco:CharacterString>unknown</gco:CharacterString>\n\t\t\t\t\t</gmd:version>\n\t\t\t\t</gmd:MD_Format>\n\t\t\t</gmd:distributionFormat>\n\t\t</gmd:MD_Distribution>\n\t</gmd:distributionInfo>\n\t<gmd:dataQualityInfo>\n\t\t<gmd:DQ_DataQuality>\n\t\t\t<gmd:scope>\n\t\t\t\t<gmd:DQ_Scope>\n\t\t\t\t\t<gmd:level>\n\t\t\t\t\t\t<gmd:MD_ScopeCode codeListValue="dataset" codeList="http://standards.iso.org/ittf/PubliclyAvailableStandards/ISO_19139_Schemas/resources/Codelist/ML_gmxCodelists.xml#MD_ScopeCode">dataset</gmd:MD_ScopeCode>\n\t\t\t\t\t</gmd:level>\n\t\t\t\t</gmd:DQ_Scope>\n\t\t\t</gmd:scope>\n\t\t\t<gmd:report>\n\t\t\t\t<gmd:DQ_DomainConsistency xsi:type="gmd:DQ_DomainConsistency_Type">\n\t\t\t\t\t<gmd:result>\t\n\t\t\t\t\t\t<gmd:DQ_ConformanceResult xsi:type="gmd:DQ_ConformanceResult_Type">\n\t\t\t\t\t\t\t<gmd:explanation>\n\t\t\t\t\t\t\t\t<gco:CharacterString>See the referenced specification</gco:CharacterString>\n\t\t\t\t\t\t\t</gmd:explanation>\n\t\t\t\t\t\t\t<gmd:pass gco:nilReason="template"/>\n\t\t\t\t\t\t</gmd:DQ_ConformanceResult>\n\t\t\t\t\t</gmd:result>\n\t\t\t\t</gmd:DQ_DomainConsistency>\n\t\t\t</gmd:report>\n\t\t\t<gmd:lineage>\n\t\t\t\t<gmd:LI_Lineage>\n\t\t\t\t\t<gmd:statement>\n\t\t\t\t\t\t<gco:CharacterString>Original data source: WATCH Forcing Data 20th Century - Tair_daily_WFD _adjusted using E-HYPE2.5.Link to original data http://www.eu-watch.org/data_availability</gco:CharacterString>\n\t\t\t\t\t</gmd:statement>\n\t\t\t\t</gmd:LI_Lineage>\n\t\t\t</gmd:lineage>\n\t\t</gmd:DQ_DataQuality>\n\t</gmd:dataQualityInfo>\n</gmd:MD_Metadata>
\.


--
-- TOC entry 3740 (class 0 OID 212453)
-- Dependencies: 308
-- Data for Name: jt_metadata_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_metadata_relationship (id, metaid, relationship_reference) FROM stdin;
\.


--
-- TOC entry 3734 (class 0 OID 212336)
-- Dependencies: 302
-- Data for Name: jt_metadata_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_metadata_resource (id, metaid, resource_reference) FROM stdin;
12	38	14
13	39	15
14	40	16
15	41	17
16	42	18
17	43	19
18	44	20
\.


--
-- TOC entry 3731 (class 0 OID 212258)
-- Dependencies: 299
-- Data for Name: jt_metadata_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_metadata_tag (id, tagid, metadata_reference) FROM stdin;
17	68	38
18	68	39
19	68	40
20	68	41
21	68	42
22	68	43
23	68	44
\.


--
-- TOC entry 3739 (class 0 OID 212435)
-- Dependencies: 307
-- Data for Name: jt_relationship_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_relationship_tag (id, relationship_reference, tagid) FROM stdin;
\.


--
-- TOC entry 3735 (class 0 OID 212354)
-- Dependencies: 303
-- Data for Name: representation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY representation (id, name, description, tags, contenttype, contentlocation, content) FROM stdin;
14	Discharge(EHYPEv2pt5).zip		14	application/zip	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SFpRNWtodFJUY00	\N
15	Land-use (EHYPEv2pt5).xlsx		15	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SkFsdmdmaHgtUVk	\N
16	Precipitation(EHYPEv2pt5).zip		16	application/zip	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8SDR3dGhSREpwcFk	\N
17	River gauges(EHYPEv2pt5).zip		17	application/zip	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8ZEtveHc0WDlvNzg	\N
18	Soils(EHYPEv2pt5).xlsx		18	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8anBOenAxZDNmekk	\N
19	Subbasin(EHYPEv2pt5).zip		19	application/zip	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8X25DSFZEZ1ljNU0	\N
20	Temperature(EHYPEv2pt5).zip		20	application/vnd.openxmlformats-officedocument.spreadsheetml.sheet	https://drive.google.com/?authuser=0#folders/0B1X74qKezeD8TUUzZ0I5OGhrNlE	\N
\.


--
-- TOC entry 3736 (class 0 OID 212369)
-- Dependencies: 304
-- Data for Name: jt_representation_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_representation_tag (id, representation_reference, tagid) FROM stdin;
\.


--
-- TOC entry 3737 (class 0 OID 212387)
-- Dependencies: 305
-- Data for Name: jt_resource_representation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_resource_representation (id, resource_reference, repid) FROM stdin;
18	14	14
19	15	15
20	16	16
21	17	17
22	18	18
23	19	19
24	20	20
\.


--
-- TOC entry 3733 (class 0 OID 212318)
-- Dependencies: 301
-- Data for Name: jt_resource_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_resource_tag (id, resource_reference, tagid) FROM stdin;
52	14	47
53	14	21
54	14	12
55	14	68
56	14	92
57	15	49
58	15	21
59	15	12
60	15	68
61	15	91
62	16	47
63	16	21
64	16	12
65	16	68
66	16	95
67	17	47
68	17	21
69	17	12
70	17	68
71	17	93
72	18	59
73	18	21
74	18	12
75	18	68
76	18	96
77	19	47
78	19	21
79	19	12
80	19	68
81	19	97
82	20	47
83	20	21
84	20	12
85	20	68
86	20	98
87	14	118
88	15	118
89	16	118
90	17	118
91	18	118
92	19	118
93	20	118
\.


--
-- TOC entry 3726 (class 0 OID 212193)
-- Dependencies: 294
-- Data for Name: taggroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY taggroup (id, name, description) FROM stdin;
3	keywords - INSPIRE themes 1.0	GEMET - INSPIRE themes, version 1.0, publication, 2008-06-01
6	keywords - Open	The keyword value is a commonly used word, formalised word or phrase used to describe the subject. While the topic category is too coarse for detailed queries, keywords help narrowing a full text search and they allow for structured keyword search.
1	access constraints	When Member States limit public access to spatial data sets and spatial data services under Article 13 of Directive 2007/2/EC, this metadata element shall provide information on the limitations and the reasons for them.\r\nIf there are no limitations on public access, this metadata element shall indicate that fact.
4	topic category	The topic category is a high-level classification scheme to assist in the grouping and topic-based search of available spatial data resources.
5	license	This tag defines the conditions for access and use of spatial data sets and services, and where applicable, corresponding fees as required by Article 5(2)(b) and Article 11(2)(f) of Directive 2007/2/EC.\r\nThe element must have values. If no conditions apply to the access and use of the resource, "no conditions apply" shall be used. If conditions are unknown, "conditions unknown" shall be used.\r\nThis element shall also provide information on any fees necessary to access and use the resource, if applicable, or refer to a uniform resource locator (URL) where information on fees is available.
7	hydrological concept	Hydrological concept of the Dataset
2	language	The language(s) used within the resource or in which the metadata elements are expressed.\r\nThe value domain of this tag is limited to the languages defined in ISO 639-2.
8	catchment	Catchment of the Level B dataset.
9	geography	This tag defines the geographical range of the datasets.
\.


--
-- TOC entry 3728 (class 0 OID 212211)
-- Dependencies: 296
-- Data for Name: jt_tag_taggroup; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_tag_taggroup (id, tag_reference, tgid) FROM stdin;
2	2	4
3	3	4
4	4	4
5	5	4
6	6	4
7	7	4
8	8	4
9	9	4
10	10	4
11	11	4
12	12	4
13	13	4
14	14	4
15	15	4
16	16	4
17	17	4
18	18	4
19	19	4
20	20	4
21	21	1
22	22	1
23	23	1
24	24	1
25	25	1
26	26	1
27	27	1
28	28	1
29	29	1
30	30	3
31	31	3
32	32	3
33	33	3
34	34	3
35	35	3
36	36	3
37	37	3
38	38	3
39	39	3
40	40	3
41	41	3
42	42	3
43	43	3
44	44	3
45	45	3
46	46	3
47	47	3
48	48	3
49	49	3
50	50	3
51	51	3
52	52	3
53	53	3
54	54	3
55	55	3
56	56	3
57	57	3
58	58	3
59	59	3
60	60	3
61	61	3
62	62	3
63	63	3
64	64	2
65	65	2
66	66	2
67	67	2
68	68	2
69	69	2
70	70	2
71	71	2
72	72	2
73	73	2
74	74	2
75	75	2
76	76	2
77	77	2
78	78	2
79	79	2
80	80	2
81	81	5
82	82	5
83	83	5
84	84	5
85	85	5
86	86	5
87	87	5
88	88	5
89	89	5
90	90	5
91	91	7
92	92	7
93	93	7
94	94	7
95	95	7
96	96	7
97	97	7
98	98	7
99	99	8
100	100	8
101	101	8
102	102	8
103	103	8
104	104	8
105	105	8
106	106	8
107	107	8
108	108	8
109	109	8
110	110	8
111	111	8
112	112	8
113	113	8
114	114	8
115	115	8
116	116	8
117	117	8
118	118	9
119	119	9
\.


--
-- TOC entry 3742 (class 0 OID 212489)
-- Dependencies: 310
-- Data for Name: jt_toresource_relationship; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY jt_toresource_relationship (id, resid, relationship_reference) FROM stdin;
\.


--
-- TOC entry 3725 (class 0 OID 212011)
-- Dependencies: 276
-- Data for Name: url; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY url (id, object_name, url_base_id) FROM stdin;
\.


--
-- TOC entry 3724 (class 0 OID 212000)
-- Dependencies: 274
-- Data for Name: url_base; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY url_base (id, prot_prefix, path, server) FROM stdin;
\.


-- Completed on 2014-06-25 14:40:20

--
-- PostgreSQL database dump complete
--

