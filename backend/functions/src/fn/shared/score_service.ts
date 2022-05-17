export function getMilestoneAnswerPoints(name: string): number {
    if (name === 'Evacuei') {
        return 2;
    } else {
        return 1;
    }
}


export function getDynamicAnswerPoints(answerName: string, selectedResponse: string): number {
    if (answerName === 'pain') {
        return getPainScore(selectedResponse);
    } else if(answerName === 'Nível de náuseas e vômitos.'){
        return getNauseScore(selectedResponse);
    }
    return 0;
}

function getPainScore(answer: string): number {
    switch (answer) {
        case '0' || '1' || '2' || '3':
            return 2;
        case '4' || '5' || '6' || '7':
            return 1;
        case '8' || '9' || '10':
            return 0;
        default:
            return 0;
    }
}

function getNauseScore(answer: string): number {
    switch (answer) {
        case '0' || '1' || '2' || '3':
            return 2;
        case '4' || '5' || '6' || '7':
            return 1;
        case '8' || '9' || '10':
            return 0;
        default:
            return 0;
    }
}