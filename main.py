import enchant

languages = ['en_US', 'tr_TR']  # ['en_US', 'fr_FR', 'es_ES', 'tr_TR', ... ]
dictionaries = {lang: enchant.Dict(lang) for lang in languages}


def check_word_in_languages(word):
    """
    Checks if a word exists in any of the dictionaries
    """
    for lang, dictionary in dictionaries.items():
        if dictionary.check(word):
            return lang


word = "arabalar"
matching_language = check_word_in_languages(word)

print(f"The word '{word}' is valid in: {matching_language}")
