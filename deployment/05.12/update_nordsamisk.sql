UPDATE assessment.answertypetextresources
	SET description = 'Áibbas ovttaoaivilis'
	WHERE language_id_fk=1083
    and answertype_id_fk=1;

UPDATE assessment.answertypetextresources
	SET description = 'Belohahkii ovttaoaivilis'
	WHERE language_id_fk=1083
    and answertype_id_fk=2;

UPDATE assessment.answertypetextresources
	SET description = 'Belohahkii sierramielalaš'
	WHERE language_id_fk=1083
    and answertype_id_fk=3;

UPDATE assessment.answertypetextresources
	SET description = 'Áibbas sierramielalaš'
	WHERE language_id_fk=1083
    and answertype_id_fk=4;

UPDATE assessment.answertypetextresources
	SET description = 'In hálit vástidit / ii áigeguovdil'
	WHERE language_id_fk=1083
    and answertype_id_fk=5;

UPDATE assessment.questiontextresources
	SET question = 'In hálit vástidit dán kategoriijas'
	WHERE language_id_fk=1083
    and question_id_fk in (1,2,3);