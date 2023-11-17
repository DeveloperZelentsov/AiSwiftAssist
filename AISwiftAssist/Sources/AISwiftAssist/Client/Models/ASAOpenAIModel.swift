//
//  File.swift
//  
//
//  Created by Alexey on 11/17/23.
//

import Foundation

/// Represents various models created and used by OpenAI and its partners.
public enum ASAOpenAIModel: String {

    /// Model "text-search-babbage-doc-001" created by openai-dev, a document search model based on the Babbage architecture.
    case textSearchBabbageDoc001 = "text-search-babbage-doc-001"

    /// Model "gpt-3.5-turbo-16k" created by openai-internal, a high-capacity version of GPT-3.5 optimized for performance.
    case gpt3_5Turbo16k = "gpt-3.5-turbo-16k"

    /// Model "curie-search-query" created by openai-dev, designed for efficient and effective search query processing.
    case curieSearchQuery = "curie-search-query"

    /// Model "text-davinci-003" created by openai-internal, an advanced iteration of the Davinci text processing model.
    case textDavinci003 = "text-davinci-003"

    /// Model "text-search-babbage-query-001" created by openai-dev, specialized in processing and understanding search queries.
    case textSearchBabbageQuery001 = "text-search-babbage-query-001"

    /// Model "babbage" created by openai, a versatile and powerful AI model.
    case babbage = "babbage"

    /// Model "babbage-search-query" created by openai-dev, tailored for searching and analyzing large datasets.
    case babbageSearchQuery = "babbage-search-query"

    /// Model "text-babbage-001" created by openai, a variant of the Babbage model with specific enhancements.
    case textBabbage001 = "text-babbage-001"

    /// Model "text-similarity-davinci-001" created by openai-dev, designed for high-accuracy text similarity analysis.
    case textSimilarityDavinci001 = "text-similarity-davinci-001"

    /// Model "davinci-similarity" created by openai-dev, optimized for comparing and contrasting large text data sets.
    case davinciSimilarity = "davinci-similarity"

    /// Model "code-davinci-edit-001" created by openai, focused on refining and editing code-based text inputs.
    case codeDavinciEdit001 = "code-davinci-edit-001"

    /// Model "curie-similarity" created by openai-dev, a model for analyzing and comparing text for similarities.
    case curieSimilarity = "curie-similarity"

    /// Model "babbage-search-document" created by openai-dev, designed for document retrieval and information extraction.
    case babbageSearchDocument = "babbage-search-document"

    /// Model "curie-instruct-beta" created by openai, a version of the Curie model trained for instructional and explanatory tasks.
    case curieInstructBeta = "curie-instruct-beta"

    /// Model "text-search-ada-doc-001" created by openai-dev, specialized in document search and analysis.
    case textSearchAdaDoc001 = "text-search-ada-doc-001"

    /// Model "davinci-instruct-beta" created by openai, an iteration of Davinci trained for instructional content generation.
    case davinciInstructBeta = "davinci-instruct-beta"

    /// Model "gpt-3.5-turbo-instruct" created by system, a turbocharged version of GPT-3.5 with instructional capabilities.
    case gpt3_5TurboInstruct = "gpt-3.5-turbo-instruct"

    /// Model "text-similarity-babbage-001" created by openai-dev, for analyzing text similarities using the Babbage architecture.
    case textSimilarityBabbage001 = "text-similarity-babbage-001"

    /// Model "text-search-davinci-doc-001" created by openai-dev, a Davinci-based model for document search and analysis.
    case textSearchDavinciDoc001 = "text-search-davinci-doc-001"

    /// Model "gpt-3.5-turbo-instruct-0914" created by system, an advanced version of GPT-3.5-turbo with specialized instructive abilities.
    case gpt3_5TurboInstruct0914 = "gpt-3.5-turbo-instruct-0914"

    /// Model "babbage-similarity" created by openai-dev, focuses on comparing text snippets for similarities using Babbage architecture.
    case babbageSimilarity = "babbage-similarity"

    /// Model "text-embedding-ada-002" created by openai-internal, designed for embedding text using the Ada model.
    case textEmbeddingAda002 = "text-embedding-ada-002"

    /// Model "davinci-search-query" created by openai-dev, an advanced Davinci model optimized for search queries.
    case davinciSearchQuery = "davinci-search-query"

    /// Model "text-similarity-curie-001" created by openai-dev, a Curie-based model for analyzing text similarities.
    case textSimilarityCurie001 = "text-similarity-curie-001"

    /// Model "text-davinci-001" created by openai, an early iteration of the Davinci model with advanced text processing capabilities.
    case textDavinci001 = "text-davinci-001"

    /// Model "text-search-davinci-query-001" created by openai-dev, designed for processing search queries using the Davinci model.
    case textSearchDavinciQuery001 = "text-search-davinci-query-001"

    /// Model "ada-search-document" created by openai-dev, an Ada-based model for document search and retrieval.
    case adaSearchDocument = "ada-search-document"

    /// Model "ada-code-search-code" created by openai-dev, specialized in searching and analyzing code snippets using the Ada model.
    case adaCodeSearchCode = "ada-code-search-code"

    /// Model "babbage-002" created by system, a second iteration of the Babbage model with enhanced capabilities.
    case babbage002 = "babbage-002"

    /// Model "gpt-4-vision-preview" created by system, a preview version of GPT-4 with vision processing capabilities.
    case gpt4VisionPreview = "gpt-4-vision-preview"

    /// Model "davinci-002" created by system, a second iteration of the Davinci model with improvements in text processing.
    case davinci002 = "davinci-002"

    /// Model "gpt-4-0314" created by openai, a version of GPT-4 specialized in various AI tasks.
    case gpt40314 = "gpt-4-0314"

    /// Model "davinci-search-document" created by openai-dev, focused on document retrieval and analysis using the Davinci model.
    case davinciSearchDocument = "davinci-search-document"

    /// Model "curie-search-document" created by openai-dev, a Curie-based model designed for document search and retrieval.
    case curieSearchDocument = "curie-search-document"

    /// Model "babbage-code-search-code" created by openai-dev, specialized in code search and analysis using the Babbage model.
    case babbageCodeSearchCode = "babbage-code-search-code"

    /// Model "gpt-4-0613" created by openai, an iteration of GPT-4 with specific enhancements and capabilities.
    case gpt40613 = "gpt-4-0613"

    /// Model "text-search-ada-query-001" created by openai-dev, an Ada model designed for processing search queries.
    case textSearchAdaQuery001 = "text-search-ada-query-001"

    /// Model "code-search-ada-text-001" created by openai-dev, optimized for searching text in code using the Ada model.
    case codeSearchAdaText001 = "code-search-ada-text-001"

    /// Model "gpt-3.5-turbo-16k-0613" created by openai, a high-capacity, performance-optimized version of GPT-3.5.
    case gpt3_5Turbo16k0613 = "gpt-3.5-turbo-16k-0613"

    /// Model "babbage-code-search-text" created by openai-dev, a Babbage model for text search in code.
    case babbageCodeSearchText = "babbage-code-search-text"

    /// Model "code-search-babbage-code-001" created by openai-dev, specialized for code searching using the Babbage model.
    case codeSearchBabbageCode001 = "code-search-babbage-code-001"

    /// Model "ada-search-query" created by openai-dev, an Ada-based model optimized for search query processing.
    case adaSearchQuery = "ada-search-query"

    /// Model "ada-code-search-text" created by openai-dev, focused on text search in code using the Ada model.
    case adaCodeSearchText = "ada-code-search-text"

    /// Model "tts-1-hd" created by system, a high-definition text-to-speech model.
    case tts1Hd = "tts-1-hd"

    /// Model "text-search-curie-query-001" created by openai-dev, a Curie-based model for effective search query processing.
    case textSearchCurieQuery001 = "text-search-curie-query-001"

    /// Model "text-search-curie-doc-001" created by openai-dev, a Curie-based document search model.
    case textSearchCurieDoc001 = "text-search-curie-doc-001"

    /// Model "text-curie-001" created by openai, an early version of the Curie model for versatile text processing.
    case textCurie001 = "text-curie-001"

    /// Model "curie" created by openai, a powerful and adaptable AI model for various text-related tasks.
    case curie = "curie"

    /// Model "canary-tts" created by system, a test version of a text-to-speech model.
    case canaryTTS = "canary-tts"

    /// Model "tts-1" created by openai-internal, a versatile text-to-speech model.
    case tts1 = "tts-1"

    /// Model "gpt-3.5-turbo-1106" created by system, an enhanced version of GPT-3.5 Turbo.
    case gpt3_5Turbo1106 = "gpt-3.5-turbo-1106"

    /// Model "gpt-3.5-turbo-0613" created by openai, a variant of GPT-3.5 Turbo.
    case gpt3_5Turbo0613 = "gpt-3.5-turbo-0613"

    /// Model "gpt-4-1106-preview" created by system, a preview version of GPT-4.
    case gpt41106Preview = "gpt-4-1106-preview"

    /// Model "gpt-3.5-turbo-0301" created by openai, an iteration of GPT-3.5 Turbo.
    case gpt3_5Turbo0301 = "gpt-3.5-turbo-0301"

    /// Model "gpt-3.5-turbo" created by openai, a powerful and fast version of GPT-3.5.
    case gpt3_5Turbo = "gpt-3.5-turbo"

    /// Model "davinci" created by openai, a highly advanced and capable AI model for various applications.
    case davinci = "davinci"

    /// Model "dall-e-2" created by system, an AI model specializing in generating and manipulating images.
    case dallE2 = "dall-e-2"

    /// Model "tts-1-1106" created by system, a text-to-speech model with specific enhancements.
    case tts11106 = "tts-1-1106"

    /// Model "dall-e-3" created by system, an advanced version of the DALL-E image generation model.
    case dallE3 = "dall-e-3"
}

