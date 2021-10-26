--Select * from "Plays";
--Select * from "PlayStatusLogs";
--Select * from "Videos";
--Select * from "Images";
--Select * from "Edition"; 
--Select * from "Badges";
--Select * from "SportRadarInfo";


--Seleccionar los videos de un playID
--select v.play_id, v.video_type, v.description, v.duration, v.video_url, v.file_name from "Plays" as p, "Videos" as v WHERE p.id = v.play_id AND v.play_id = '0020500589_932';


--Seleccionar las imagenes de un PlayID
--SELECT i.play_id, i.id, i.image_url, i.rating FROM "Plays" as p, "Images" as i WHERE i.play_id = p.id AND i.play_id = '0020500589_932';
--AND {{playsTable.selectedRow.data.id}} = i.play_id

