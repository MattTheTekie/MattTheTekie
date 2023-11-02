        sudo apt update
        sudo apt -y install xmltv retry
        go install github.com/aquilax/m3u-combine@latest
        cd /home/runner/work/MattTheTekie/MattTheTekie/Personal-Scripts/IPTV/0      
        openvpn vpn.ovpn --auth-user-pass <(echo -e ${{ secrets.VPN_USERNAME }}"\n"${{ secrets.VPN_PASSWORD }}) &
        wget -O 0_1.m3u https://github.com/iptv-org/iptv/raw/master/streams/us_samsung.m3u
        wget -O 0_2.m3u https://i.mjh.nz/PlutoTV/us.m3u8
        wget -O 0_3.m3u ${{ secrets.TV2 }}
        wget -O plex.m3u https://i.mjh.nz/Plex/us.m3u8
        wget -O uk_samsung.m3u https://github.com/iptv-org/iptv/raw/master/streams/uk_samsung.m3u 
        wget -O uk_rakuten.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/uk_rakuten.m3u 
        wget -O uk_sportstribal.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/uk_sportstribal.m3u 
        wget -O us_adultswim.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_adultswim.m3u 
        wget -O us_bumblebee.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_bumblebee.m3u 
        wget -O us_distro.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_distro.m3u 
        wget -O us_fubo.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_fubo.m3u 
        wget -O us_glewedtv.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_glewedtv.m3u 
        wget -O us_imdbtv.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_imdbtv.m3u 
        wget -O us_klowdtv.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_klowdtv.m3u 
        wget -O us_redbox.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_redbox.m3u 
        wget -O us_roku.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_roku.m3u 
        wget -O us_stirr.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_stirr.m3u 
        wget -O us_tcl.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_tcl.m3u 
        wget -O us_tubi.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_tubi.m3u 
        wget -O us_vizio.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_vizio.m3u 
        wget -O us_xumo.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/us_xumo.m3u 
        wget -O ie_samsung.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/ie_samsung.m3u 
        wget -O ca_stingray.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/ca_stingray.m3u 
        wget -O ca_samsung.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/ca_samsung.m3u 
        wget -O au_samsung.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/au_samsung.m3u 
        wget -O jp.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/jp.m3u 
        wget -O jp_org.m3u https://raw.githubusercontent.com/iptv-org/iptv/master/streams/jp.m3u 
        curl -H "Authorization: token ${{ secrets.JAPAN }}" \
        -H 'Accept: application/vnd.github.v3.raw' \
        -o 1.m3u \
        -L ${{ secrets.JP3 }}
        wget -O plex.xml https://i.mjh.nz/Plex/us.xml
        wget -O samsung.xml https://i.mjh.nz/SamsungTVPlus/all.xml
        wget -O pluto.xml https://i.mjh.nz/PlutoTV/us.xml
        wget -O anime.xml.gz https://epgshare01.online/epgshare01/epg_ripper_ID1.xml.gz
        gunzip anime.xml.gz
        wget -O iptvjapan.xml https://www.bevy.be/bevyfiles/japan.xml