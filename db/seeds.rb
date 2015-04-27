resource_site_seeds = [
    {:name=>"First Presbyterian Church of Brooklyn", :description=>"Congregation of different races, ethnicities, nationalities, ages, sexual orientations, marital statuses, professions, incomes and abilities that reflect and honor that diversity.", :address=>"124 Henry Street, , Brooklyn, NY 11201", :eligibility_id=>2},
    {:name=>"First Unitarian Church in Brooklyn Gay-Straight Alliance", :description=>"Inclusion/expressions/advocacy of LGBT concerns in congregational life and society.", :address=>"50 Monroe Place, , Brooklyn, NY 11201", :eligibility_id=>3},
    {:name=>"Broadway United Church of Christ", :description=>"LGBT-affirming congregation of United Church of Christ, 5pm Sunday worship service, followed by dinner. All welcome.", :address=>"2504 Broadway, at 93rd Street, New York, NY 10025", :eligibility_id=>3},
    {:name=>"Callen-Lorde Community Health Center", :description=>"Services targeted at New York’s LGBT communities, including: case management, primary medical care, HIV testing, health, Health Outreach to Teens (HOTT) program ages: 13-24. Free sexual and reproductive health services including: condoms, birth control, emergency contraception, STD testing and treatment, HIV testing, pregnancy testing, and mental health counseling.", :address=>"356 W. 18th St., 2nd floor, New York, NY 10011", :eligibility_id=>5},
    {:name=>"Congregation Beit Simchat Torah", :description=>"Synagogue serving LGBTQ community of NYC since 1973. Has an active Trans Empowerment Committee.", :address=>"57 Bethune St. , , New York, NY 10014", :eligibility_id=>5},
    {:name=>"Greenwich Village Youth Council's Neutral Zone", :description=>"Safe space for LGBTQ youth to drop in and hang out, socialize, enjoy activities. Also homeless or at-risk services.\r\n", :address=>"2273 Third Avenue, , New York, NY 10035", :eligibility_id=>2},
    {:name=>"HIV Law Project", :description=>"Services for HIV+ Bronx and Manhattan residents, including: housing, immigration, benefits, and healthcare. Bilingual English/Spanish.", :address=>"15 Maiden Lane, 18th floor, New York, NY 10038", :eligibility_id=>2},
    {:name=>"Jan Hus Presbyterian Church", :description=>"LGBT-affirming congregation and homeless outreach program.", :address=>"351 East 74th street, , New York, NY 10021", :eligibility_id=>2},
    {:name=>"Lawyers for Children", :description=>"The LGBTQ Youth Project specializes in referrals and legal representation for LGBTQ young people in foster care.", :address=>"110 Lafayette Street, , New York, NY 10013", :eligibility_id=>4},
    {:name=>"Lennox Avenue Health Center", :description=>"Services for females only. Low cost sexual and reproductive health services including: condoms, birth control, emergency contraception, STD testing and treatment, HIV testing, and pregnancy testing", :address=>"115 West 116th Street, , New York, NY 10026", :eligibility_id=>2},
    {:name=>"LGBT Law Association of Greater New York", :description=>"Services include: a resource center, lawyer assistance program, LGBT life planning, legal walk-in clinics on Long Island and in Manhattan, the West Village Trans-Legal Clinic", :address=>"799 Broadway, #340, New York, NY 10003", :eligibility_id=>1},
    {:name=>"New Alternatives", :description=>"Services for LGBT homeless youth ages 16-24, including: case management, life skills workshops, community building, educational and discussion groups, support groups, hot meals, food pantry, clothing, and toiletries. Walk-in Sundays 6-8 pm and Tuesdays 5-9 pm.", :address=>"83 Christopher Street, , New York, NY 10014", :eligibility_id=>1},
    {:name=>"Project SOL (Speak Out Loud)", :description=>"Project SOL is specifically designed for L.G.B.T.Q. youth, young adults and their allies based in the Lower East Side.", :address=>"80 Pitt Street Community Center, , New York, NY 10002", :eligibility_id=>6},
    {:name=>"Seventh Day Adventist Kinship - NY Chapter", :description=>"Lesbian and gay religious support group for present and former Seventh Day Adventists and friends.", :address=>"95 W 95th St, #21F, New York, NY 10025", :eligibility_id=>3},
    {:name=>"Trinity Place", :description=>"Services for young adults ages 18- 24, including: a 10 bed transitional shelter, case management, money for transportation, food, etc. and partner with other organizations that offer medical and mental health services.", :address=>"164 W. 100th St., , New York, NY 10025", :eligibility_id=>3},
    {:name=>"The Neuroscience Institute", :description=>"Non-profit outpatient neurological clinic offeringadults (19+) diagnosis and treatment for neurological disorders, including developmental disabilities, epilepsy, stroke, multiple sclerosis, memory disorders, neuro-oncology, autonomic disorders, and sleep disorders.", :address=>"59-16 174th Street, , Fresh Meadows, NY 11365", :eligibility_id=>4},
    {:name=>"Family PEACE Program", :description=>"Public program providing women and their children (ages 0-13) who have experienced domestic violence in their home with bilingual (English/Spanish) mental health services.", :address=>"534 West 135th Street, , New York, NY 10031", :eligibility_id=>4},
    {:name=>"South Bronx Job Corps Academy", :description=>"Public program offeringindividuals ages 16-24 free job training and job placement in either a residential or commuter setting.", :address=>"1771 Andrews Avenue, , Bronx, NY 10453", :eligibility_id=>4},
    {:name=>"Queens Adult Learning Center (QALC)", :description=>"Public learning center providing individuals ages 21+ with free education courses, including basic education, GED, ESL, and computer applications classes.", :address=>"27-35 Jackson Avenue, 3rd Floor, Long Island City, NY 11101", :eligibility_id=>6},
    {:name=>"Brooklyn Adult Learning Center (BALC)", :description=>"Public center offering individuals ages 21+ free day, evening, and Saturday courses, including basic education, TASC, ESL, computer literacy classes, A+ electronic, computer repair, technical education, licensed practical nursing, and certified nursing assistant programs,career education and medical billing and coding.", :address=>"475 Nostrand Avenue, , Brooklyn, NY 11216", :eligibility_id=>5}
]

eligibility_seeds = [
    {:eligibility=>"Men", :description=>"Men Only"},
    {:eligibility=>"Women", :description=>"Women Only"},
    {:eligibility=>"Cancer", :description=>"Cancer Only"},
    {:eligibility=>"Abuse Survivors", :description=>"Abuse Survivors Only"},
    {:eligibility=>"Children", :description=>"Children Only"},
    {:eligibility=>"Test Eligibility", :description=>"Test Eligibility Only"}
]

user_seed = {:email=>"user@healthify.com", :password=>"healthify", :password_confirmation=>"healthify", :admin=>true}

ActiveRecord::Base.connection.execute("TRUNCATE TABLE resource_sites, eligibilities RESTART IDENTITY")
ResourceSite.delete_all
Eligibility.delete_all
User.create(user_seed)
eligibility_seeds.each { |es| Eligibility.create(es) }
resource_site_seeds.each { |rss| ResourceSite.create(rss) }
