// questionnaire.js -- Extract and save a JSON file from a survey form
// Copyright (C) 2025  Keisuke Kurosawa <k.kurochan9630@gmail.com>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

function saveQuestionnaire(type) {
    const form = document.getElementById(type);
    const formData = new FormData(form);

    const username = formData.get('username');
    const questionnaire = extractQuestionnaire(type, formData);

    const json = `${JSON.stringify(questionnaire, null, 2)}\n`;
    const blob = new Blob([json], {'type': 'application/json'});
    const url = URL.createObjectURL(blob);

    const a = document.createElement('a');
    a.href = url;
    a.download = [type, username].join('-').concat('.json');
    a.click();

    URL.revokeObjectURL(url);
}

function extractQuestionnaire(type, formData) {
    const questions = new Map();

    formData.keys().forEach((key) => {
        const answer = getAnswer(formData, key);

        if (answer !== null) {
            questions.set(key, answer);
        }
    });

    const questionnaire = {
        'type': type,
        'questions': Object.fromEntries(questions)
    };

    return questionnaire;
}

function getAnswer(formData, key) {
    let answer = '';

    switch (key) {
    case 'target':
        answer = formData.get(key);

        break;
    case 'motivation':
    case 'via':
    case 'moderator':
    case 'support-mentor':
    case 'challenge-planning':
    case 'active-rate':
        answer = formData.get(key).replaceAll("\n", '');

        break;
    case 'satisfaction-rating':
    case 'difference':
    case 'next':
    case 'future':
    case 'future-motivation':
    case 'supported':
    case 'moderator-likely':
        answer = formData.getAll(key);

        break;
    case 'future-motivation-freeform':
        answer = formData.getAll('future-motivation').includes('その他') ? formData.get(key) : '(ここに回答を改行を入れずに書いてください)';

        break;
    case 'etc':
        answer = formData.get(key).replaceAll("\n", '');

        if (answer.length <= 0) {
            answer = '(ここに回答を改行を入れずに書いてください)';
        }

        break;
    default:
        answer = null;
    }

    return answer;
}
