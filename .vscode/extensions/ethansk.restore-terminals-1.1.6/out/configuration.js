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
exports.getConfiguration = void 0;
const vscode = require("vscode");
const text_encoding_1 = require("text-encoding");
const path = require("path");
function getConfiguration() {
    var _a, _b, _c, _d;
    return __awaiter(this, void 0, void 0, function* () {
        const keepExistingTerminalsOpen = vscode.workspace
            .getConfiguration("restoreTerminals")
            .get("keepExistingTerminalsOpen");
        const artificialDelayMilliseconds = vscode.workspace
            .getConfiguration("restoreTerminals")
            .get("artificialDelayMilliseconds");
        const terminalWindows = vscode.workspace
            .getConfiguration("restoreTerminals")
            .get("terminals");
        const runOnStartup = vscode.workspace
            .getConfiguration("restoreTerminals")
            .get("runOnStartup");
        const configFromFile = yield getConfigurationFromJsonFile();
        return {
            keepExistingTerminalsOpen: (_a = configFromFile === null || configFromFile === void 0 ? void 0 : configFromFile.keepExistingTerminalsOpen) !== null && _a !== void 0 ? _a : keepExistingTerminalsOpen,
            artificialDelayMilliseconds: (_b = configFromFile === null || configFromFile === void 0 ? void 0 : configFromFile.artificialDelayMilliseconds) !== null && _b !== void 0 ? _b : artificialDelayMilliseconds,
            terminalWindows: (_c = configFromFile === null || configFromFile === void 0 ? void 0 : configFromFile.terminalWindows) !== null && _c !== void 0 ? _c : terminalWindows,
            runOnStartup: (_d = configFromFile === null || configFromFile === void 0 ? void 0 : configFromFile.runOnStartup) !== null && _d !== void 0 ? _d : runOnStartup,
        };
    });
}
exports.getConfiguration = getConfiguration;
function getConfigurationFromJsonFile() {
    return __awaiter(this, void 0, void 0, function* () {
        const { workspaceFolders } = vscode.workspace;
        if (!workspaceFolders) {
            return undefined;
        }
        let configData;
        //find any workspace with the config
        for (const folder of workspaceFolders) {
            try {
                const configFilePath = vscode.Uri.file(path.join(folder.uri.fsPath, ".vscode", "restore-terminals.json"));
                const fileData = yield vscode.workspace.fs.readFile(configFilePath);
                const fileDataString = new text_encoding_1.TextDecoder("utf-8").decode(fileData);
                configData = JSON.parse(fileDataString);
            }
            catch (error) {
                console.log("No config in workspace", folder, error.Message);
            }
        }
        if (!configData)
            return undefined;
        return Object.assign(Object.assign({}, configData), { terminalWindows: configData === null || configData === void 0 ? void 0 : configData.terminals });
    });
}
//# sourceMappingURL=configuration.js.map