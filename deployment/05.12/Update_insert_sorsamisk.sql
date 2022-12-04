INSERT INTO assessment.categorytextresources(category_id_fk, name, description, language_id_fk)
VALUES
      (1,'hammoe','Hammoe/hammoedimmie',6203),
	  (2,'pedagogisk','Pedagogeles jïh didaktihkeles kvaliteete',6203),
	  (3,'learoesoejkesje','Åtnoe learoesoejkesje-vierhkeste',6203);

INSERT INTO assessment.answertypetextresources(answertype_id_fk, name, description, language_id_fk)
VALUES
      (1,'heltenig','Eevre sïemes', 6203),
      (2,'delvisenig','Såemiesmearan sïemes',6203),
      (3,'delvisuenig','Såemiesmearan ov-sïemes',6203),
	  (4,'heltuenig','Eevre ov-sïemes',6203),
      (5,'ikkeaktuelt','Im sïjhth vaestiedidh/Ij sjyöhtehke',6203);

UPDATE assessment.questiontextresources
	SET question = 'Im sïjhth daam kategorijem vaestiedidh'
	WHERE language_id_fk=6203
    and question_id_fk in (1,2,3);