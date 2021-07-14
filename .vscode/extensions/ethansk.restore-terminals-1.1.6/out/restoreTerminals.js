"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const utils_1 = require("./utils");
const DEFAULT_ARTIFICAL_DELAY = 300;
const SPLIT_TERM_CHECK_DELAY = 100;
const MAX_TERM_CHECK_ATTEMPTS = 500; //this times SPLIT_TERM_CHECK_DELAY is the timeout
function restoreTerminals(configuration) {
    var _a;
    return __awaiter(this, void 0, void 0, function* () {
        console.log("restoring terminals", configuration);
        const { keepExistingTerminalsOpen, artificialDelayMilliseconds, terminalWindows, } = configuration;
        if (!terminalWindows) {
            // vscode.window.showInformationMessage("No terminal window configuration provided to restore terminals with.") //this might be annoying
            return;
        }
        if (vscode.window.activeTerminal && !keepExistingTerminalsOpen) {
            vscode.window.terminals.forEach((terminal) => {
                //i think calling terminal.dispose before creating the new termials causes error because the terminal has disappeard and it fux up. we can do it after, and check that the terminal we are deleting is not in the list of terminals we just created
                console.log(`Disposing terminal ${terminal.name}`);
                terminal.dispose();
            });
        }
        yield utils_1.delay(artificialDelayMilliseconds !== null && artificialDelayMilliseconds !== void 0 ? artificialDelayMilliseconds : DEFAULT_ARTIFICAL_DELAY); //without delay it starts bugging out
        let commandsToRunInTerms = [];
        //create the terminals sequentially so theres no glitches, but run the commands in parallel
        for (const terminalWindow of terminalWindows) {
            if (!terminalWindow.splitTerminals) {
                // vscode.window.showInformationMessage("No split terminal configuration provided to restore terminals with.") //this might be annoying
                return;
            }
            const term = vscode.window.createTerminal({
                name: (_a = terminalWindow.splitTerminals[0]) === null || _a === void 0 ? void 0 : _a.name,
            });
            term.show();
            yield utils_1.delay(artificialDelayMilliseconds !== null && artificialDelayMilliseconds !== void 0 ? artificialDelayMilliseconds : DEFAULT_ARTIFICAL_DELAY);
            //the first terminal split is already created from when we called createTerminal
            if (terminalWindow.splitTerminals.length > 0) {
                const { commands, shouldRunCommands } = terminalWindow.splitTerminals[0];
                commands &&
                    commandsToRunInTerms.push({
                        commands,
                        shouldRunCommands: shouldRunCommands !== null && shouldRunCommands !== void 0 ? shouldRunCommands : true,
                        terminal: term,
                    });
            }
            for (let i = 1; i < terminalWindow.splitTerminals.length; i++) {
                const splitTerminal = terminalWindow.splitTerminals[i];
                const createdSplitTerm = yield createNewSplitTerminal(splitTerminal.name);
                const { commands, shouldRunCommands } = splitTerminal;
                commands &&
                    commandsToRunInTerms.push({
                        commands,
                        shouldRunCommands: shouldRunCommands !== null && shouldRunCommands !== void 0 ? shouldRunCommands : true,
                        terminal: createdSplitTerm,
                    });
            }
        }
        yield utils_1.delay(artificialDelayMilliseconds !== null && artificialDelayMilliseconds !== void 0 ? artificialDelayMilliseconds : DEFAULT_ARTIFICAL_DELAY);
        //we run the actual commands in parallel
        commandsToRunInTerms.forEach((el) => __awaiter(this, void 0, void 0, function* () {
            yield runCommands(el.commands, el.terminal, el.shouldRunCommands);
        }));
    });
}
exports.default = restoreTerminals;
function runCommands(commands, terminal, shouldRunCommands = true) {
    return __awaiter(this, void 0, void 0, function* () {
        for (let j = 0; j < (commands === null || commands === void 0 ? void 0 : commands.length); j++) {
            const command = commands[j] + (shouldRunCommands ? "" : ";"); //add semicolon so all commands can run properly after user presses enter
            terminal.sendText(command, shouldRunCommands);
        }
    });
}
function createNewSplitTerminal(name) {
    return __awaiter(this, void 0, void 0, function* () {
        return new Promise((resolve, reject) => __awaiter(this, void 0, void 0, function* () {
            var _a;
            const numTermsBefore = vscode.window.terminals.length;
            yield vscode.commands.executeCommand("workbench.action.terminal.split");
            if (name) {
                yield vscode.commands.executeCommand("workbench.action.terminal.renameWithArg", {
                    name,
                });
            }
            let attemptCount = 0;
            while (true) {
                const numTermsNow = (_a = vscode.window.terminals) === null || _a === void 0 ? void 0 : _a.length;
                if (attemptCount > MAX_TERM_CHECK_ATTEMPTS) {
                    reject();
                    break;
                }
                if (numTermsNow > numTermsBefore) {
                    resolve(vscode.window.terminals[numTermsNow - 1]);
                    break; //we know the terminal has now been split
                }
                else {
                    yield utils_1.delay(SPLIT_TERM_CHECK_DELAY);
                    attemptCount++;
                }
            }
        }));
    });
}
//# sourceMappingURL=restoreTerminals.js.map