-- PROCEDURE: assessment.insert_assessment(integer, character varying, character varying, character varying, timestamp without time zone, character varying, character varying)

-- DROP PROCEDURE IF EXISTS assessment.insert_assessment(integer, character varying, character varying, character varying, timestamp without time zone, character varying, character varying);

CREATE OR REPLACE PROCEDURE assessment.insert_assessment(
	IN userid integer,
	IN teachingaid character varying,
	IN instanceid character varying,
	IN groupassessmentid character varying,
	IN createddatetime timestamp without time zone,
	IN usercomments character varying,
	IN teachingaidsupplier character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
IF NOT EXISTS(SELECT * FROM assessment.assessment where instance_id = instanceid) THEN
INSERT INTO assessment.assessment (user_id_fk, teachingaid,instance_id, groupassessment_id_fk, created_datetime, user_comments, teachingaid_supplier) VALUES (userid, teachingaid,instanceid,groupassessmentid, createddatetime, usercomments, teachingaidsupplier);
END IF;
END
$BODY$;
ALTER PROCEDURE assessment.insert_assessment(integer, character varying, character varying, character varying, timestamp without time zone, character varying, character varying)
    OWNER TO postgres;

-- PROCEDURE: invitations.insert_invitation(integer, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS invitations.insert_invitation(integer, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE invitations.insert_invitation(
	IN userid integer,
	IN gvid character varying,
	IN frist character varying,
	IN laeremiddel character varying,
	IN laereplan character varying,
	IN mottakereposter character varying,
	IN opprettetdato character varying,
	IN assessmenttypeid integer,
	IN laereplankode character varying,
	IN bortvalgtsporsmaal character varying,
	IN laeremiddelleverandor character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
IF NOT EXISTS(SELECT * FROM invitations.invitations where gv_id = gvid) THEN
INSERT INTO invitations.invitations (user_id_fk, gv_id, frist, laeremiddel, laereplan, mottaker_eposter, opprettet_dato,assessmenttype_id_fk,laereplankode,bortvalgtsporsmaal, laeremiddel_leverandor)
VALUES (userid, gvid, frist, laeremiddel, laereplan, mottakereposter,opprettetdato,assessmenttypeid,laereplankode,bortvalgtsporsmaal, laeremiddelleverandor);
END IF;
END
$BODY$;
ALTER PROCEDURE invitations.insert_invitation(integer, character varying, character varying, character varying, character varying, character varying, character varying, integer, character varying, character varying, character varying)
    OWNER TO postgres;
