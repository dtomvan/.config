/**
 * @name SubtleDevicePrompt
 *
 * @version 1.1.1
 * @description Replace the dialog when connecting a new audio device with a minimal card
 * @author Jed Fox
 * @authorId 706842348239323199
 * @invite KK8WeSxrWf
 * @source https://github.com/j-f1/discord-plugins/blob/main/SubtleDevicePrompt/SubtleDevicePrompt.plugin.js
 */

module.exports = class SubtleDevicePrompt {
  load() {
    this.modalModule = BdApi.findModuleByProps("openModalLazy", "updateModal");
  }

  start() {
    this.cancelPatch = BdApi.monkeyPatch(this.modalModule, "openModalLazy", {
      async instead(patch) {
        const component = await patch.methodArguments[0]()

        const element = component({
          onClose: () => {},
          transitionState: null,
        });

        if (element.type.displayName === "ConnectedDevice") {
          try {
            const instance = new element.type(element.props);
            const content = instance.render();
            const [
              {
                props: {
                  children: {
                    props: { children: headerText },
                  },
                },
              }, // content: “Discord has detected [...] to it?” + “don't show again” button
              ,
              {
                props: {
                  children: {
                    props: {
                      children: [
                        {
                          props: {
                            onClick: onClose,
                            children: closeButtonText,
                          },
                        },
                        {
                          props: {
                            onClick: onAccept,
                            children: acceptButtonText,
                          },
                        },
                      ],
                    },
                  },
                },
              },
            ] = content.props.children;

            // HTML cloned from the “voice connected” card
            const root = document.createElement("div");
            root.className = "container-1zzFcN";
            root.style.display = "flex";
            root.style.flexDirection = "column";

            const heading = document.createElement("div");
            heading.style.display = "flex";
            root.appendChild(heading);

            const headingTextPart = document.createElement("div");
            headingTextPart.style.display = "flex";
            headingTextPart.style.flexDirection = "column";
            headingTextPart.style.flexGrow = "1";
            heading.appendChild(headingTextPart);

            const closeButton = document.createElement("button");
            closeButton.type = "button";
            // from mute/deafen buttons
            closeButton.className =
              "bubutton-12Fmur enabled-9OeuTA button-f2h6uQ lookBlank-21BCro";
            closeButton.style.padding = "0";
            closeButton.onclick = () => root.remove();
            // from the close button when clicking the server name
            closeButton.innerHTML = `<svg width="20" height="20" viewBox="0 0 18 18" style="stroke-width: 2;stroke: currentColor;"><path d="M4.5 4.5l9 9" stroke-linecap="round"></path><path d="M13.5 4.5l-9 9" stroke-linecap="round"></path></svg>`;
            heading.appendChild(closeButton);

            const header = document.createElement("strong");
            header.textContent = headerText;
            header.style.fontSize = "14px";
            header.style.paddingBottom = "2px";
            headingTextPart.appendChild(header);

            const deviceName = document.createElement("div");
            deviceName.textContent = element.props.device.displayName;
            // from the channel name of the voice card
            deviceName.className =
              "size12-oc4dx4 subtext-2HDqJ7 channel-3prF2u";
            deviceName.style.paddingBottom = "4px";
            deviceName.style.textDecoration = "none";
            headingTextPart.appendChild(deviceName);

            // from video/screenshare buttons
            const buttonBar1 = document.createElement("div");
            buttonBar1.className = "actionButtons-2vEOUh";
            buttonBar1.style.paddingBottom = "4px";
            root.appendChild(buttonBar1);
            const cancelButton = document.createElement("button");
            cancelButton.type = "button";
            cancelButton.className =
              "button-1EGGcP buttonColor-3bP3fX button-f2h6uQ lookFilled-yCfaCM colorBrand-I6CyqQ sizeSmall-wU2dO- grow-2sR_-F";
            cancelButton.textContent = closeButtonText;
            cancelButton.onclick = () => {
              onClose();
              root.remove();
            };
            buttonBar1.appendChild(cancelButton);

            const buttonBar2 = document.createElement("div");
            buttonBar2.className = "actionButtons-2vEOUh";
            root.appendChild(buttonBar2);
            const acceptButton = document.createElement("button");
            acceptButton.type = "button";
            acceptButton.style.flexGrow = "1";
            // .button-1YfofB removed to make it pop
            acceptButton.className =
              "button-1EGGcP button-f2h6uQ lookFilled-yCfaCM colorBrand-I6CyqQ sizeSmall-wU2dO- grow-2sR_-F";
            acceptButton.textContent = acceptButtonText;
            acceptButton.onclick = () => {
              onAccept();
              root.remove();
            };
            buttonBar2.appendChild(acceptButton);

            root.style.backgroundColor =
              "var(--brand-experiment, var(--brand))";
            root.style.transition = "background-color 1s";

            // parent of voice connected card
            document
              .querySelector(".wrapper-3Hk9OB")
              .insertAdjacentElement("afterbegin", root);
            setTimeout(() => (root.style.backgroundColor = ""), 250);
          } catch (e) {
            BdApi.showToast(
              "Something went wrong with SubtleDevicePrompt! Please report this to Jed using the Discord server linked in the settings.",
              { type: "error", timeout: 7e3, forceShow: true }
            );
            console.error(e);
            return patch.callOriginalMethod();
          }
        } else {
          return patch.callOriginalMethod();
        }
      },
    });
  }

  stop() {
    this.cancelPatch && this.cancelPatch();
    this.cancelPatch = null;
  }
};
