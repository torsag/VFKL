INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
VALUES
	  (1,'design','Design/hábbmim',4155),
	  (2,'pedagåvgålasj','Pedagåvgålasj ja didaktalasj kvalitiehtta',4155),
	  (3,'oahppoplánajt','Gåktu oahppoplánajt adnet',4155);

INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
VALUES
      (1,'heltenig','Guorrasav ållu', 4155),
      (2,'delvisenig','Guorrasav muhtem mudduj',4155),
      (3,'delvisuenig','Iv ållu guorrasa',4155),
	  (4,'heltuenig','Iv åvvånis guorrasa',4155),
      (4,'ikkeaktuelt','Iv sidá vásstedit / ij la ájggeguovddelis',4155);

UPDATE assessment.questiontextresources
	SET question = 'Iv sidá dán kategorijjan vásstedit'
	WHERE language_id_fk=4155
    and question_id_fk in (1,2,3);
