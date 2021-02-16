import pandas as pd
import spacy
import numpy as np
import childespy
#python -m spacy download en_core_web_lg in the environment


nlp = spacy.load("en_core_web_lg")

def spacy_extraction(str):
    doc = nlp(str)
    return(pd.DataFrame([{'text':token.text, 'lemma':token.lemma_, 'pos':token.pos_, 'tag':
          token.tag_, 'dependency':token.dep_,
            'morph':token.morph} for token in doc]))

spacy_extraction('what does the bus driver say?')

pvd_idx = childespy.get_sql_query('select * from corpus where name = "Providence"').iloc[0]['id']


pvd_utts = childespy.get_sql_query('select * from utterance where corpus_id = '+str(pvd_idx) ,
        db_version = "2020.1")

def fix_gloss(gloss):
    # migt be better to split these glosses (black+bird -> black bird),but then we lose the alignment 
    return(str(gloss).replace('+','').replace('_',''))
pvd_utts.gloss = [fix_gloss(x) for x in pvd_utts.gloss]

# add back punctuation from the utterance type
punct_for_type = {
    'question':'?',
    'declarative':'.',
    'self interruption':'.',
    'interruption':'!',
    'trail off':'...',
    'interruption question':'?',
    'trail off question':'?',
    'imperative_emphatic':'!' 
}
pvd_utts['punct'] = [punct_for_type[x] if x in punct_for_type else '.'
                        for x in pvd_utts.type ]

# add the speaker code (for compatibility with a fine-tuned model that has speaker identity)
pvd_utts = pvd_utts.loc[[x is not None for x in pvd_utts.punct]]


# build a single form that is appropriate for running through the tokenizer
pvd_utts['gloss_with_punct'] = [x['gloss'] + x['punct'] for x in pvd_utts.to_dict('records')] 
pvd_utts.shape



spacy_examples = pd.concat([spacy_extraction(x) for x in pvd_utts.head(10)['gloss_with_punct']])




spacy_examples



test_str = 'what do the bus drivers say?'
test_spacy = nlp(test_str)
dir(test_spacy[4])