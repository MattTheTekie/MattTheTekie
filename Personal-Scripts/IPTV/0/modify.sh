        cd /home/runner/work/MattTheTekie/MattTheTekie/Personal-Scripts/IPTV/0
        sed 's/.png", /.png" group-title="Free TV", /' -i plex.m3u
        cat merge_1.txt | ~/go/bin/m3u-combine > 0.m3u
        sed 's/\( group-title="\)[^"]*/\1Free TV/' -i 0.m3u
        sed 's/status="online", /status="online", group-title="Free TV" '/ -i 0.m3u
        sed 's/status="blocked", /status="blocked", group-title="Free TV" '/ -i 0.m3u
        sed 's/status="timeout", /status="timeout", group-title="Free TV" '/ -i 0.m3u
        sed 's/status="error", /status="error", group-title="Free TV" '/ -i 0.m3u
        cat merge_2.txt | ~/go/bin/m3u-combine > combined.m3u
        sed 's/group-title="Free TV", group-title="Free TV"/group-title="Free TV",'/ -i combined.m3u
        awk '/En Español|en español|En español|en Español|español|Español|Espanol|espanol|Latino|latino|spain|Spain|Spanish|spanish|Latin|Latin|Latido|latido| con| la| Sony Canal| Perfecto| perfecto| Mundo| amigos| escándalos| Estrella | nosotras| noticias| Cine| ViX| Tu Cine| Telemundo| Séptimo| Saber Mas| RCN Mas| RCN Más| PrendeTV| Niños| MMC| misterios sin resolver| Mi obsesión favorita| MegaNoticias| La corriente| Juntos| Investiga| Foodies| Éxitos|Crímenes imperfectos| Corazón|CNN RESUMEN|Chiquilines|Canela|Badass novelas| Amantes / {while (/En Español|en español|En español|en Español|español|Español|Espanol|espanol|Latino|latino|spain|Spain|Spanish|spanish|Latin|Latin|Latido|latido| con| la| Sony Canal| Perfecto| perfecto| Mundo| amigos| escándalos| Estrella | nosotras| noticias| Cine| ViX| Tu Cine| Telemundo| Séptimo| Saber Mas| RCN Mas| RCN Más| PrendeTV| Niños| MMC| misterios sin resolver| Mi obsesión favorita| MegaNoticias| La corriente| Juntos| Investiga| Foodies| Éxitos|Crímenes imperfectos| Corazón|CNN RESUMEN|Chiquilines|Canela|Badass novelas| Amantes / && getline>0) ; next} 1' combined.m3u > FREE.m3u        
        mv FREE.m3u combined.m3u
        sed 's/(1080p)//' -i combined.m3u
        sed 's/(720p)//' -i combined.m3u
        sed 's/(540p)//' -i combined.m3u
        sed -i 's/\[//' -i combined.m3u
        sed -i 's/\]//' -i combined.m3u
        sed -i 's/(YouTube)//' -i combined.m3u
        sed -s 's/(French AI Translated Closed-Captioning)//' -i combined.m3u
        sed -s 's/(Bahasa Indonesia AI Translated Closed-Captioning)//' -i combined.m3u
        sed -s 's/(Chinese Traditional AI Translated Closed-Captioning)//' -i combined.m3u
        sed -s 's/Not 24\/7//' -i combined.m3u
        sed -s 's/(480p)//' -i combined.m3u
        sed -s 's/(360p)//' -i combined.m3u
        sed -s 's/(240p)//' -i combined.m3u
        sed -s 's/(England)//' -i combined.m3u
        sed -s 's/(144p)//' -i combined.m3u
        sed -s 's/(474p)//' -i combined.m3u
        sed -s 's/(2160p)//' -i combined.m3u
        sed -s 's/(STIRR)//' -i combined.m3u
        sed -s 's/(Canada)//' -i combined.m3u
        sed -s 's/(Test for Bitcentral)//' -i combined.m3u
        sed -s 's/(BumbleBee TV)//' -i combined.m3u
        sed -s 's/(Bumblebee TV)//' -i combined.m3u
        sed -s 's/BumbleBee TV//' -i combined.m3u
        sed -s 's/Bumblebee TV//' -i combined.m3u
        sed -s 's/(English Subs)//' -i combined.m3u
        sed -s 's/(Indonesian Subs)//' -i combined.m3u
        sed -s 's/(XUMO)//' -i combined.m3u
        sed -s 's/(Redbox)//' -i combined.m3u
        sed -s 's/Geo-blocked//' -i combined.m3u
        sed -s 's/(768p)//' -i combined.m3u
        sed -s 's/(432p)//' -i combined.m3u
        sed -s 's/(504p)//' -i combined.m3u
        sed -s 's/(UK)//' -i combined.m3u
        sed -s 's/(576p)//' -i combined.m3u
        sed -s 's/(234p)//' -i combined.m3u
        sed -s 's/(Australia)//' -i combined.m3u
        sed -i 's/STIRR//' -i combined.m3u
        sed -i 's/US SPORT//' -i combined.m3u
        sed -i 's/STIRR CITY//' -i combined.m3u
        sed 's/group-title="Free TV",/group-title="Free TV", /' -i 'combined.m3u'
        sed 's/group-title="Free TV",  /group-title="Free TV", /' -i 'combined.m3u'
        sed 's/24\/7 Anime/247 Anime/' -i combined.m3u
        sed 's/group-title="24\/7 Anime", /group-title="24\/7 Anime", [ANIME] /' -i 'combined.m3u'
        sed 's/group-title="Japanese TV", /group-title="Japanese TV", [JAPAN] /' -i 'combined.m3u'
        sed 's/group-title="Free TV", /group-title="Free TV", [FREE] /' -i 'combined.m3u'
        sed 's/247 Anime", /247 Anime", [ANIME] /' -i 'combined.m3u'
        sed 's/247 Anime/24\/7 Anime/' -i combined.m3u
        sed 's/2014.svg.png", /2014.svg.png", [JAPAN] /' -i combined.m3u
        sed 's/247 Anime/24\/7 Anime/' -i combined.m3u
        sed 's/status="error",/status="online",/' -i combined.m3u 
        sed 's/status="timeout",/status="online",/' -i combined.m3u 
        sed 's/status="online",/status="online", group-title="Japanese TV" [JAPAN] /' -i combined.m3u 
        sed 's/group-title="Japanese TV",group-title="Japanese TV"/group-title="Japanese TV",/' -i combined.m3u
        sed 's/group-title="Japanese TV", group-title="Japanese TV" /group-title="Japanese TV", /' -i 'combined.m3u'
        sed 's/24\/7 Anime/247 Anime/' -i combined.m3u
        sed -s 's/(720p)//' -i 'combined.m3u'
        sed -s 's/(360p)//' -i 'combined.m3u'
        sed -s 's/(French AI Translated Closed-Captioning)//' -i 'combined.m3u'
        sed -s 's/(Bahasa Indonesia AI Translated Closed-Captioning)//' -i 'combined.m3u'
        sed -s 's/(Chinese Traditional AI Translated Closed-Captioning)//' -i 'combined.m3u'
        sed -s 's/(540p)//' -i 'combined.m3u'
        sed -s 's/(480p)//' -i 'combined.m3u'
        sed -s 's/(1080p)//' -i 'combined.m3u'
        sed -s 's/(720p NewHome)//' -i 'combined.m3u'
        sed -s 's/(720p Official)//' -i 'combined.m3u'
        sed -s 's/(1080p Official)//' -i 'combined.m3u'
        sed -s 's/(720p Official 2)//' -i 'combined.m3u'
        sed -s 's/(720p Stream)//' -i 'combined.m3u'
        sed -s 's/(720p iHome)//' -i 'combined.m3u'
        sed -s 's/(English Subs)//' -i 'combined.m3u'
        sed -s 's/[][]//' -i 'combined.m3u'
        sed -s 's/Not 24\/7//' -i 'combined.m3u'
        sed -s 's/JAPAN]//' -i 'combined.m3u'
        sed -s 's/[[]]//' -i 'combined.m3u'
        sed -i 's/(YouTube)//' -i 'combined.m3u'
        sed 's/group-title="Japanese TV",/group-title="Japanese TV",[JAPAN]/' -i 'combined.m3u'
        sed -i 's/  / /' -i 'combined.m3u'
        sed 's/2014.svg.png", /2014.svg.png", [JAPAN] /' -i combined.m3u 
        sed 's/247 Anime/24\/7 Anime/' -i 'combined.m3u'
        sed -i '/H3D90/d' combined.m3u
        sed 's/ABC News/ABC N2/' -i 'combined.m3u'
        sed -i '/ABC N2/d' combined.m3u
        sed -i '/AccuWeather Now/d' combined.m3u
        sed -i '/BACKSTAGE/d' combined.m3u
        sed -i '/Bein Sport Xtra/d' combined.m3u
        sed -i '/Bloomberg TV US/d' combined.m3u
        sed -i '/bon appétit/d' combined.m3u
        sed -i '/Buzzr/d' combined.m3u
        sed -i '/CBSN/d' combined.m3u
        sed -i '/ChiveTV/d' combined.m3u
        sed -i '/Chive TV/d' combined.m3u
        sed -i '/Dallas Cowboy Cheerleaders/d' combined.m3u
        sed -i '/Cinevault 80s/d' combined.m3u
        sed -i '/Cinevault Westerns/d' combined.m3u
        sed -i '/Degrassi The Next Generation/d' combined.m3u
        sed -i '/Dove/d' combined.m3u
        sed -i '/DryBar Comedy/d' combined.m3u
        sed -i '/Dust/d' combined.m3u
        sed -i '/EDGESport/d' combined.m3u
        sed -i '/EDGEsport/d' combined.m3u
        sed -i '/Electric Now/d' combined.m3u
        sed -i '/Euronews Portuguese/d' combined.m3u
        sed -i '/Euronews Deutsch/d' combined.m3u
        sed -i '/Euronews English/d' combined.m3u
        sed -i '/Vevo 80s/d' combined.m3u
        sed -i '/Zoo Moo/d' combined.m3u
        sed -i '/QVC Live/d' combined.m3u
        sed -i '/Qello Concerts by Stingray/d' combined.m3u
        sed -i '/Outside TV/d' combined.m3u
        sed -i '/NBC News Now/d' combined.m3u
        sed -i '/Mystery Science Theater 3000/d' combined.m3u
        sed -i '/MavTV Select/d' combined.m3u
        sed -i '/MOVIESPHERE/d' combined.m3u
        sed -i '/MavTV/d' combined.m3u
        sed -i '/LEGO Channels/d' combined.m3u
        sed -i '/Kidoodle TV/d' combined.m3u
        sed -i '/Ion Plus/d' combined.m3u
        sed -i '/GUSTOTV/d' combined.m3u
        sed -i '/Glory Kickboxing/d' combined.m3u
        sed -i '/Fuel TV/d' combined.m3u
        sed -i '/FTF Sports/d' combined.m3u
        sed -i '/FTF For the fans/d' combined.m3u
        sed -i '/FilmStreams/d' combined.m3u
        sed -i '/Chicken Soup For The Soul/d' combined.m3u
        sed -i '/Euronews Italiano/d' combined.m3u
        sed -i '/FilmRise Classic TV on Redbox/d' combined.m3u
        sed -i '/Fox Soul/d' combined.m3u
        sed -i '/fubo Sports Network/d' combined.m3u
        sed -i '/Newsmax/d' combined.m3u
        sed -i '/ PersuitUp/d' combined.m3u
        sed -i '/PeopleTV/d' combined.m3u
        sed -i '/Pac 12 Insider/d' combined.m3u
        sed -i '/Pac12 Insider/d' combined.m3u
        sed -i '/People are Awesome/d' combined.m3u
        sed -i '/Qwest TV Classical/d' combined.m3u
        sed -i '/Qwest TV Mix/d' combined.m3u
        sed -i '/Qwest TV Jazz & Beyond/d' combined.m3u
        sed -i '/Real nosey/d' combined.m3u
        sed -i '/Reelz/d' combined.m3u
        sed -i '/RetroCrush TV/d' combined.m3u
        sed -i '/Revry News/d' combined.m3u
        sed -i '/Shout! Factory/d' combined.m3u
        sed -i '/Shout! Factory TV Stream/d' combined.m3u
        sed -i '/Slightly Off by IFC/d' combined.m3u
        sed -i '/So Yummy!/d' combined.m3u
        sed -i '/Stingray Djazz/d' combined.m3u
        sed -i '/Surf Now TV/d' combined.m3u
        sed -i '/The Jack Hannah Channel/d' combined.m3u
        sed -i '/Today All Day/d' combined.m3u
        sed -i '/USA TODAY/d' combined.m3u
        sed -i '/USA TODAY Sportswire/d' combined.m3u
        sed -i '/Weatherspy/d' combined.m3u
        sed -i '/Weathernation/d' combined.m3u
        sed -i '/The Young Turks/d' combined.m3u
        sed -i '/IGN1/d' combined.m3u
        sed -i '/IGN TV/d' combined.m3u
        sed -i '/s Voice News/d' combined.m3u
        sed -i '/ PersuitUp/d' combined.m3u
        sed -i '/Moonbug Kids/d' combined.m3u
        sed -i '/AsianCrush/d' combined.m3u
        sed -i '/Yahoo! Finance/d' combined.m3u
        sed 's/MagellanTV NOW/Magellan TV Now 2/' -i combined.m3u
        sed -i '/beIN Sports Xtra/d' combined.m3u
        sed -i '/Tastemade France/d' combined.m3u
        sed 's/All Reality by WE tv/All Reality WE tv 2/' -i combined.m3u
        sed 's/Anime All day/Anime All Day 2/' -i combined.m3u
        sed 's/ BABY SHARK TV/ Baby Shark TV 2/' -i combined.m3u
        sed -i '/EstrellaTV/d' combined.m3u
        sed -i '/Freebie TV - Los Pitufos/d' combined.m3u
        sed -i '/Grande-ish/d' combined.m3u
        sed -i '/Lucha Libre AAA/d' combined.m3u
        sed -i '/Misterios sin resolver/d' combined.m3u
        sed -i '/ MOTORVISION.TV/d' combined.m3u
        sed -i '/ Nosey Escándalos/d' combined.m3u
        sed -i '/ Nosey Casos/d' combined.m3u
        sed -i '/ So...Real/d' combined.m3u
        sed -i '/Pelis y Popcorn/d' combined.m3u
        sed -i '/ El Conflicto TV/d' combined.m3u
        sed -i '/ Emergencia 911/d' combined.m3u
        sed -i '/ Spike ¡extremo!/d' combined.m3u
        sed -i '/ Fight Network/d' combined.m3u
        sed -i '/ Horrorfy/d' combined.m3u
        sed -i 's/24\/7 TV", /24\/7 TV", [24\/7] /' -i combined.m3u
        sed -i 's/group-title="24\/7 TV", [24\/7]/group-title="24\/7 TV"/' -i combined.m3u
        sed 's/] 24\/7  /] /' -i 'combined.m3u' 
        sed 's/ 24\/7 //' -i 'combined.m3u' 
        sed 's/7]/7] /' -i 'combined.m3u' 
        sed 's/7]  /7] /' -i 'combined.m3u' 
        sed 's/247 TV/24\/7 TV/' -i 'combined.m3u'
        sed 's/group-title="24\/7 TV",TV/group-title="24\/7 TV",24\/TV/' -i 'combined.m3u'
        sed 's/group-title="24\/7 TV",24\/TV/group-title="24\/7 TV", [24\/7 TV]/' -i 'combined.m3u'
        sed 's/group-title="Free TV", FREE]/group-title="Free TV", [FREE]/' -i 'combined.m3u'
        sed 's/group-title="24\/7 Anime", ANIME]/group-title="24\/7 Anime", [ANIME]/' -i 'combined.m3u'
        sed 's/group-title="Documentary", DOC]/group-title="Documentary", [DOC]/' -i 'combined.m3u'
        python3 rem_dup_1.py
        sed -i 's/group-title="Japanese TV", \[JAPAN\] JAPAN/group-title="Japanese TV", \[JAPAN\]/' combined.m3u
        sed -i 's/group-title="24\/7 Anime", \[ANIME\] ANIME/group-title="24\/7 Anime", \[ANIME\]/' combined.m3u
        sed -i 's/group-title="24\/7 Cartoon",/group-title="24\/7 Cartoon", \[TOON\]/' combined.m3u
        sed -i 's/group-title="Free TV", \[FREE\] /group-title="Free TV", /' combined.m3u
        sed -i 's/group-title="Free TV", /group-title="Free TV", \[FREE\] /' combined.m3u
        mv combined.m3u combined_draft.m3u
        sed 's/",/" group-title="Japanese TV", \[JAPAN\] /' -i 'jp_org.m3u'
        sed -s 's/(360p)//' -i 'jp_org.m3u'
        sed -s 's/(576p)//' -i 'jp_org.m3u'
        sed -s 's/(540p)//' -i 'jp_org.m3u'
        sed -s 's/(480p)//' -i 'jp_org.m3u'
        sed -s 's/(720p)//' -i 'jp_org.m3u'
        sed -s 's/(1080p)//' -i 'jp_org.m3u'
        sed -s 's/Not 24\/7//' -i 'jp_org.m3u'
        sed -s 's/[[]]//' -i 'jp_org.m3u'
        sed -i 's/(YouTube)//' -i 'jp_org.m3u'
        sed -s 's/(French Subs)//' -i jp_org.m3u
        sed -s 's/(Spanish Subs)//' -i jp_org.m3u
        sed -s 's/(Portuguese Subs)//' -i jp_org.m3u
        sed -i 's/(Youtube)//' -i 'jp_org.m3u'
        cat merge_3.txt | ~/go/bin/m3u-combine > combined.m3u
        sed 's/ythlsgo/ythls-lane/' -i combined.m3u
        python3 zoro.py
        sed -s 's/\[JAPAN\] JAPAN /\[JAPAN\] /' -i 'combined.m3u'
        sed 's/NHKBS1.jp/ＮＨＫＢＳ１.jp/' -i combined.m3u
        sed 's/NHKBSPremium.jp/ＮＨＫＢＳプレミアム.jp/' -i combined.m3u
        sed 's/NHKEducationalTV.jp/NHK東京　教育.jp/' -i combined.m3u
        sed 's/NHKGeneralTV.jp/NHK東京　総合.jp/' -i combined.m3u
        sed 's/JOAKDTV.jp/NHK東京　総合.jp/' -i combined.m3u
        sed 's/BSAsahi.jp/ＢＳ朝日１.jp/' -i combined.m3u
        sed 's/BSFuji.jp/ＢＳフジ・181.jp/' -i combined.m3u
        sed 's/BSNipponTV.jp/ＢＳ日テレ.jp/' -i combined.m3u
        sed 's/BSTBS.jp/ＢＳ－ＴＢＳ.jp/' -i combined.m3u
        sed 's/BSTVTokyo.jp/BSテレ東.jp/' -i combined.m3u
        sed 's/WOWOWCinema.jp/歌謡ポップスチャンネル.jp/' -i combined.m3u
        sed 's/WOWOWLive.jp/ＷＯＷＯＷライブ.jp/' -i combined.m3u
        sed 's/WOWOWPrime.jp/ＷＯＷＯＷプライム.jp/' -i combined.m3u
        sed 's/.us", /.us", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed 's/.ca", /.ca", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed 's/.nl", /.nl", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed 's/.uk", /.uk", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed 's/.fr", /.fr", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed 's/.au", /.au", group-title="Free TV", [FREE] '/ -i combined.m3u
        sed -i -E 's/#EXTINF:-1(.*), (.+)/#EXTINF:-1\1, group-title="Free TV", [FREE] \2/' combined.m3u
        sed -i 's/\[FREE\] \[FREE\]/[FREE]/g' combined.m3u
        sed -i 's/\[FREE\] \[FREE\]/[ANIME]/g' combined.m3u
        sed -i 's/\[FREE\] \[FREE\]/[TOON]/g' combined.m3u
        sed -i 's/\[FREE\] \[FREE\]/[JAPAN]/g' combined.m3u
        sed -i 's/group-title="Free TV", //g; s/\[FREE\] \([^\[]*\[ANIME\]\)/\1/g' combined.m3u
        sed -i 's/group-title="Free TV", //g; s/\[FREE\] \([^\[]*\[TOON\]\)/\1/g' combined.m3u
        sed -i 's/group-title="Free TV", //g; s/\[FREE\] \([^\[]*\[JAPAN\]\)/\1/g' combined.m3u
        touch merge.xml
        tv_merge -i pluto.xml -m plex.xml -o free.xml
        tv_merge -i free.xml -m samsung.xml -o free2.xml
        tv_merge -i anime.xml -m iptvjapan.xml -o merge1.xml
        tv_merge -i merge1.xml -m japan_bk.xml -o merge2.xml
        tv_merge -i merge2.xml -m free2.xml -o merge.xml
        rm -rf ../.git/objects/pack
        mkdir 1 && cd 1
        cp ../merge.xml SATANSLAYER666_666_hehehe_merge.xml
        cp ../combined.m3u SATANSLAYER666_666_hehehe_combined.m3u
        wget $YAY
        unzip -o site.zip
        rm site.zip
        wget $YAY
